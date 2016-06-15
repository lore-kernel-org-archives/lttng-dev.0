From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: stack validation warning on lttng-modules bytecode interpreter
Date: Wed, 15 Jun 2016 19:13:39 +0000 (UTC)
Message-ID: <734452688.38065.1466018019445.JavaMail.zimbra@efficios.com>
References: <1074038231.37468.1466009716273.JavaMail.zimbra@efficios.com> <20160615181817.vvnf66z6cpwcraq7@treble>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160615181817.vvnf66z6cpwcraq7@treble>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jun 15, 2016, at 2:18 PM, Josh Poimboeuf jpoimboe@redhat.com wrote:

> On Wed, Jun 15, 2016 at 04:55:16PM +0000, Mathieu Desnoyers wrote:
>> Hi Josh,
>> 
>> I notice that with gcc 6.1.1, kernel 4.6, with
>> CONFIG_STACK_VALIDATION=y, building lttng-modules master
>> at commit 6c09dd94 gives this warning:
>> 
>> lttng-modules/lttng-filter-interpreter.o: warning: objtool:
>> lttng_filter_interpret_bytecode()+0x58: sibling call from callable instruction
>> with changed frame pointer
>> 
>> this object implements a bytecode interpreter using an explicit
>> jump table (see
>> https://github.com/lttng/lttng-modules/blob/master/lttng-filter-interpreter.c)
>> 
>> If I define "INTERPRETER_USE_SWITCH" at the top of the file,
>> thus using the switch-case fallback implementation, the
>> warning vanishes.
>> 
>> We use an explicit jump table rather than a switch case whenever
>> possible for performance reasons.
>> 
>> I notice that tools/objtool/builtin-check.c needs to be aware of
>> switch-cases transformed into jump tables by the compiler. Are
>> explicit jump tables supported by the stack validator ? Do we
>> need to add annotation to our code ?
> 
> Hi Mathieu,
> 
> Unfortunately objtool doesn't know how to validate this type of jump
> table.  So to avoid the warning you'll need to add an annotation to tell
> objtool to ignore it:
> 
>  STACK_FRAME_NON_STANDARD(lttng_filter_interpret_bytecode);
> 
> We had to annotate __bpf_prog_run() in the kernel for the same reason.

Thanks for the tip! Unfortunately it does not seem to work.

objdump -t lttng/lttng-filter-interpreter.o output gives:

0000000000000000 l    d  __func_stack_frame_non_standard        0000000000000000 __func_stack_frame_non_standard
0000000000000000 l     O __func_stack_frame_non_standard        0000000000000008 __func_stack_frame_non_standard_lttng_filter_interpret_bytecode

Running objtool check (built in O0) in gdb on lttng-filter-interpreter.o
built with the STACK_FRAME_NON_STANDARD define, it appears that the
following function:

static bool ignore_func(struct objtool_file *file, struct symbol *func)
{
        struct rela *rela;
        struct instruction *insn;

        /* check for STACK_FRAME_NON_STANDARD */
        if (file->whitelist && file->whitelist->rela)
                list_for_each_entry(rela, &file->whitelist->rela->rela_list, list)
                        if (rela->sym->sec == func->sec &&
                            rela->addend == func->offset)
                                return true;

        /* check if it has a context switching instruction */
        func_for_each_insn(file, func, insn)
                if (insn->type == INSN_CONTEXT_SWITCH)
                        return true;

        return false;
}

For lttng_filter_interpret_bytecode, while in the first list
iteration:

(gdb) print rela->sym->sec
$18 = (struct section *) 0x7ffff7e20010
(gdb) print func->sec
$19 = (struct section *) 0x7ffff7e20010

But

(gdb) print rela->addend
$20 = 0
(gdb) print func->offset
$21 = 928

So for some reason it never match the ignore_func.
This happens both when I build lttng-modules as a kernel module,
and when I build it into the kernel image.

Any idea why ?

Thanks,

Mathieu

> 
> --
> Josh

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
