# buildifier: disable=module-docstring
def _dummy_rule_impl(ctx):
    return []

dummy_rule = rule(
    implementation = _dummy_rule_impl,
)

def _transistor_transition_impl(settings, _):
    flavor = settings["@//:flavor"]
    print("flavor from settings = %s" % flavor)

    return {"//command_line_option:compilation_mode": flavor}

transistor_transition = transition(
    implementation = _transistor_transition_impl,
    inputs = [
        "@//:flavor",
    ],
    outputs = ["//command_line_option:compilation_mode"],
)

def _transistor_rule_impl(ctx):
    depsets = []
    for dep in ctx.attr.deps:
        depsets.append(dep.files)
    return DefaultInfo(files = depset(transitive = depsets))

transistor_rule = rule(
    implementation = _transistor_rule_impl,
    attrs = {
        "deps": attr.label_list(cfg = transistor_transition),
        "_allowlist_function_transition": attr.label(
            default = "@bazel_tools//tools/allowlists/function_transition_allowlist",
        ),
    },
)
