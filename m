From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: stack validation warning on lttng-modules bytecode interpreter
Date: Wed, 15 Jun 2016 13:18:17 -0500
Message-ID: <20160615181817.vvnf66z6cpwcraq7@treble>
References: <1074038231.37468.1466009716273.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1074038231.37468.1466009716273.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Jun 15, 2016 at 04:55:16PM +0000, Mathieu Desnoyers wrote:
> Hi Josh,
> 
> I notice that with gcc 6.1.1, kernel 4.6, with
> CONFIG_STACK_VALIDATION=y, building lttng-modules master
> at commit 6c09dd94 gives this warning:
> 
> lttng-modules/lttng-filter-interpreter.o: warning: objtool: 
> lttng_filter_interpret_bytecode()+0x58: sibling call from callable instruction with changed frame pointer
> 
> this object implements a bytecode interpreter using an explicit
> jump table (see https://github.com/lttng/lttng-modules/blob/master/lttng-filter-interpreter.c)
> 
> If I define "INTERPRETER_USE_SWITCH" at the top of the file,
> thus using the switch-case fallback implementation, the
> warning vanishes.
> 
> We use an explicit jump table rather than a switch case whenever
> possible for performance reasons.
> 
> I notice that tools/objtool/builtin-check.c needs to be aware of
> switch-cases transformed into jump tables by the compiler. Are
> explicit jump tables supported by the stack validator ? Do we
> need to add annotation to our code ?

Hi Mathieu,

Unfortunately objtool doesn't know how to validate this type of jump
table.  So to avoid the warning you'll need to add an annotation to tell
objtool to ignore it:

  STACK_FRAME_NON_STANDARD(lttng_filter_interpret_bytecode);

We had to annotate __bpf_prog_run() in the kernel for the same reason.

-- 
Josh
