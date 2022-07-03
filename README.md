This command works:
  bazel cquery somepath(transistor,dummy) --transitions=lite --//:flavor=dbg
  
This command fails:
  bazel cquery somepath(transistor,dummy) --transitions=lite --//:flavor=opt
