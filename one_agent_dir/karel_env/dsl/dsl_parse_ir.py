import numpy as np
from collections import defaultdict
import copy
import sys
import pprint

import dsl_data

# generate quad-address code for karel-env executor
# quad-address (label, bool_or_action, goto_label_true, goto_label_false)


ir_label_idx = -1

def newlabel():
    global ir_label_idx
    ir_label_idx += 1
    return ir_label_idx


def check_and_apply(queue, rule):
    r = rule[0].split()
    l = len(r)
    if len(queue) >= l:
        t = queue[-l:]
        if list(list(zip(*t))[0]) == r:
            print("apply rule: {}, len: {}".format(rule, l))
            new_t = rule[1](list(list(zip(*t))[1]), list(list(zip(*t))[2]))
            del queue[-l:]
            queue.extend(new_t)
            print("apply rule {} and extend {}".format(r, new_t))
            return True
    return False

rules = []

# k, n, s = fn(k, n)
# k: karel_world
# n: num_call
# s: success
# c: condition [True, False]
MAX_FUNC_CALL = 500


def r_prog(t, ir):
    stmt = t[3]
    ir_code = ir[3]

    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False
        return stmt(k, n + 1)
    return [('prog', fn, ir_code)] 
rules.append(('DEF run m( stmt m)', r_prog, []))


def r_stmt(t, ir):
    stmt = t[0]
    ir_code = ir[0]

    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False
        return stmt(k, n + 1)
    return [('stmt', fn, ir_code)]
rules.append(('while_stmt', r_stmt, []))
rules.append(('repeat_stmt', r_stmt, []))
rules.append(('stmt_stmt', r_stmt, []))
rules.append(('action', r_stmt, []))
rules.append(('if_stmt', r_stmt, []))
rules.append(('ifelse_stmt', r_stmt, []))


def r_stmt_stmt(t, ir):
    stmt1, stmt2 = t[0], t[1]
    ir_code1, ir_code2 = ir[0], ir[1]

    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False
        k, n, s = stmt1(k, n + 1)
        if not s: return k, n, s
        if n > MAX_FUNC_CALL: return k, n, False
        return stmt2(k, n)
    return [('stmt_stmt', fn, ir_code1 + ir_code2)]
rules.append(('stmt stmt', r_stmt_stmt, []))


def r_if(t, ir):
    cond, stmt = t[2], t[5]
    ir_cond, ir_stmt = ir[2], ir[5]
    true_label = newlabel()
    false_label = newlabel()
    # assuming ir_cond only has one line of (label, bool_or_action, goto_label_true, goto_label_false)
    ir_cond[0][2], ir_cond[0][3] = true_label, false_label
    ir_stmt[0][0] = true_label
    # add null instruction for false branch
    ir_stmt_false = [[false_label, None, None, None]]

    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False
        k, n, s, c = cond(k, n + 1)
        if not s: return k, n, s
        if c: return stmt(k, n)
        else: return k, n, s
    return [('if_stmt', fn, ir_cond + ir_stmt + ir_stmt_false)]
rules.append(('IF c( cond c) i( stmt i)', r_if, []))


def r_ifelse(t, ir):
    cond, stmt1, stmt2 = t[2], t[5], t[9]
    ir_cond, ir_stmt_true, ir_stmt_false = ir[2], ir[5], ir[9]
    true_label = newlabel()
    false_label = newlabel()
    ir_cond[0][2] = true_label 
    ir_cond[0][3] = false_label
    ir_stmt_true[0][0] = true_label
    ir_stmt_false[0][0] = false_label

    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False
        k, n, s, c = cond(k, n + 1)
        if not s: return k, n, s
        if c: return stmt1(k, n)
        else: return stmt2(k, n)
    return [('ifelse_stmt', fn, ir_cond + ir_stmt_true + ir_stmt_false)]
rules.append(('IFELSE c( cond c) i( stmt i) ELSE e( stmt e)', r_ifelse, []))


def r_while(t, ir):
    cond, stmt = t[2], t[5]
    ir_cond, ir_stmt = ir[2], ir[5]
    cond_label = newlabel()
    true_label = newlabel()
    false_label = newlabel()
    ir_cond[0][0], ir_cond[0][2], ir_cond[0][3] = cond_label, true_label, false_label
    ir_stmt[0][0] = true_label
    ir_stmt[-1][2], ir_stmt[-1][3] = cond_label, cond_label
    # add null instruction for false branch
    ir_stmt_false = [[false_label, None, None, None]]

    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False
        k, n, s, c = cond(k, n + 1)
        if not s: return k, n, s
        while(c):
            k, n, s = stmt(k, n)
            if not s: return k, n, s
            k, n, s, c = cond(k, n)
            if not s: return k, n, s
        return k, n, s
    return [('while_stmt', fn, ir_cond + ir_stmt + ir_stmt_false)]
rules.append(('WHILE c( cond c) w( stmt w)', r_while, []))


def r_repeat(t, ir):
    cste, stmt = t[1], t[3]
    ir_stmt = ir[3]
    ir_stmt_repeat = []
    for _ in range(cste()):
        ir_stmt_repeat += copy.deepcopy(ir_stmt)

    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False
        n += 1
        s = True
        for _ in range(cste()):
            k, n, s = stmt(k, n)
            if not s: return k, n, s
        return k, n, s
    return [('repeat_stmt', fn, ir_stmt_repeat)]
rules.append(('REPEAT cste r( stmt r)', r_repeat, []))


def r_cond1(t, ir):
    cond = t[0]
    ir_cond = ir[0]

    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False, False
        return cond(k, n)
    return [('cond', fn, ir_cond)]
rules.append(('cond_without_not', r_cond1, []))


def r_cond2(t, ir):
    cond = t[2]
    ir_cond = ir[2]
    ir_cond[0][1] += '_not'

    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False, False
        k, n, s, c = cond(k, n)
        return k, n, s, not c
    return [('cond', fn, r_cond)]
rules.append(('not c( cond c)', r_cond2, []))


env_rules = defaultdict(list)
for env in dsl_data.envs:
    # Condition tokens
    func_str = '''
def {}_r_cond_without_not_{}(t, ir):
    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False
        c = k.{}()
        return k, n, True, c
    ir_code = [[None, '{}', None, None]]
    return [('cond_without_not', fn, ir_code)]
    '''

    for token, api in dsl_data.obv_token_api_dict[env].items():
        current_func_str = func_str.format(env.replace('-','_'), token, api, api)
        exec(current_func_str)
        fn = eval('{}_r_cond_without_not_{}'.format(env.replace('-','_'), token))
        env_rules[env].append((token, fn, []))

    # Action tokens
    func_str = '''
def {}_r_action{}(t, ir):
    def fn(k, n):
        if n > MAX_FUNC_CALL: return k, n, False
        action = np.zeros({})
        action[{}] = 1
        try: k.state_transition(action)
        except: raise RuntimeError()
        #except: return k, n, False
        else: return k, n, True
    ir_code = [[None, 'action_{}', None, None]]
    return [('action', fn, ir_code)]
    '''

    for i, token in enumerate(dsl_data.action_token_list[env]):
        current_func_str = func_str.format(env.replace('-','_'), i+1, len(dsl_data.action_token_list[env]), i, i)
        exec(current_func_str)
        fn = eval('{}_r_action{}'.format(env.replace('-','_'), i+1))
        env_rules[env].append((token, fn, []))
        i += 1


def create_r_cste(number, ir):
    def r_cste(t, ir):
        return [('cste', lambda: number, ir[0])]
    return r_cste


for i in range(20):
    rules.append(('R={}'.format(i), create_r_cste(i, []), []))


def parse(program, environment='karel'):
    p_tokens = program.split()[::-1]
    queue = []
    applied = False
    loop_id = 0
    pprint.pprint("rules: ")
    pprint.pprint(rules + env_rules[environment])

    while len(p_tokens) > 0 or len(queue) != 1:
        print("*" * 100)
        print("loop {} p_tokens: {}".format(loop_id, p_tokens))
        print("loop {} queue:".format(loop_id))
        pprint.pprint(queue)

        if applied: applied = False
        else:
            queue.append((p_tokens.pop(), None, []))
        for rule in rules + env_rules[environment]:
            applied = check_and_apply(queue, rule)
            if applied: break
        if not applied and len(p_tokens) == 0:  # error parsing
            return None, False
        loop_id += 1
        print("*" * 100)
    return queue[0][1], True, queue[0][2]

