From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: stack validation warning on lttng-modules bytecode interpreter
Date: Wed, 15 Jun 2016 16:55:16 +0000 (UTC)
Message-ID: <1074038231.37468.1466009716273.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi Josh,

I notice that with gcc 6.1.1, kernel 4.6, with
CONFIG_STACK_VALIDATION=y, building lttng-modules master
at commit 6c09dd94 gives this warning:

lttng-modules/lttng-filter-interpreter.o: warning: objtool: 
lttng_filter_interpret_bytecode()+0x58: sibling call from callable instruction with changed frame pointer

this object implements a bytecode interpreter using an explicit
jump table (see https://github.com/lttng/lttng-modules/blob/master/lttng-filter-interpreter.c)

If I define "INTERPRETER_USE_SWITCH" at the top of the file,
thus using the switch-case fallback implementation, the
warning vanishes.

We use an explicit jump table rather than a switch case whenever
possible for performance reasons.

I notice that tools/objtool/builtin-check.c needs to be aware of
switch-cases transformed into jump tables by the compiler. Are
explicit jump tables supported by the stack validator ? Do we
need to add annotation to our code ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
