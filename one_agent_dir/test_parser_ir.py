#from karel_env import karel_option as karel
#from karel_env.dsl import get_DSL_option_v2
from karel_env.dsl.dsl_parse_ir import parse
#from karel_env.dsl.dsl_parse_and_trace import parse_and_trace
#from karel_env.generator_option_v2 import KarelStateGenerator
import pprint


def main():
    #_world = karel.Karel_world(make_error=False)
    #s_gen = KarelStateGenerator(seed=0)
    #s, _, _, _, _ = s_gen.generate_single_state(8, 8, 0.2)
    #_world.set_new_state(s)
    #dsl = get_DSL_option_v2(dsl_type='prob', seed=0, environment='karel') 
    f = open('./datasets_options_reconstruction_En_Pei/len100.txt', 'r')
    program = f.readline()
    program_str = program.strip()
    print("input program string: ", program_str)
    #exe, s_exe, record_dict = parse_and_trace(program_str, environment='karel')
    exe, s_exe, ir_code = parse(program_str, environment='karel')    
    print("parsed s_exe: ", s_exe)
    print("input program string: ", program_str)
    print("parsed exe: ", exe)
    print("parsed ir_code: ")
    pprint.pprint( ir_code)
    #print("parsed record_dict: ", record_dict)


if __name__ == "__main__":
    main()

