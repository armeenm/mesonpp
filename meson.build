project(
  'mesonpp',
  'c',
  version: '1.0.0',
  meson_version: '>=1.0.0',
  default_options: [
    'buildtype=debug',
    'b_ndebug=if-release',
    'warning_level=0',
  ]
)

cc = meson.get_compiler('c')
py3 = import('python').find_installation('python3')

main_ctg = custom_target(
  'main_gen',
  output: 'main.x',
  input: 'custom_target.py',
  command: [py3, '@INPUT@'],
  capture: true
)

main_pp = cc.preprocess(
  main_ctg,
  output: '@PLAINNAME@.c',
  compile_args: ['-C', '-x', 'c'],
)

main_gen = generator(
  find_program(files('generator.py')),
  output: '@PLAINNAME@.c',
  arguments: '@INPUT@',
  capture: true,
)

main = main_gen.process(main_pp)

mesonpp_exe = executable('mesonpp', main)
