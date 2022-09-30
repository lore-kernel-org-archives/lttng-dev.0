Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143ACC433FE
	for <lttng-dev@archiver.kernel.org>; Fri, 30 Sep 2022 21:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1664573325;
	bh=PZktHZ42DT1+tfHrF1q9GkyN7u4e0jlJaYwx8k0+SRw=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=w8JOfP8+RjRmxfDNXHpsNNGkzxTTQK+uGsZ9vDCyQJt0Rqnga3PCSlXx3cYIDeFc2
	 r5vmhgdUri5suksZYLXJTRoi+WHuQsRAi0bf483PLc65P+nGrwhrcqPRfCF+ATy7on
	 M4AbzPzi4fWnegEzeKSI70lRMIwLaasWQZasUMxIWG8vfond2+c63GK8E2c+Hkl1Qr
	 54EAjz4f2+59f3sRgdeovzlONd0qL/WfXq/is7jJWG6BlZMciRVVwn/Z+rT5X4z4xN
	 H42ih7CleI+u/2DacqrH+UpNAWgXpTJfwnhU3fji2neAZ6ETw4kJMkpgGa1rZqFUQK
	 /FCRhJey+cdRQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MfNdT0JVjz277N;
	Fri, 30 Sep 2022 17:28:45 -0400 (EDT)
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
 by lists.lttng.org (Postfix) with ESMTPS id 4MfNdS0NHZz27Ll
 for <lttng-dev@lists.lttng.org>; Fri, 30 Sep 2022 17:28:43 -0400 (EDT)
Received: from [172.16.0.72] (192-222-180-24.qc.cable.ebox.net
 [192.222.180.24])
 by smtpout.efficios.com (Postfix) with ESMTPSA id 4MfNdQ2M21zPK8;
 Fri, 30 Sep 2022 17:28:42 -0400 (EDT)
Message-ID: <e3b9a12a-4202-fe3f-dfd4-5a9c3753ee6b@efficios.com>
Date: Fri, 30 Sep 2022 17:29:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To: lttng-dev@lists.lttng.org,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>
Subject: [lttng-dev] [RELEASE] LTTng-modules 2.13.7,
 2.12.11 and LTTng-UST 2.13.5, 2.12.7
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

These bug fix releases of the LTTng kernel and user-space tracers 
contain security fixes which address memory disclosure and denial of 
service issues. Those are of relatively low severity mainly because they 
involve specific uses of the tracer by users that belong to the 
`tracing` group.

Here is the explanation of the impact for each issue corrected. The 
issues that have a security impact are tagged with [security].

The issues that were corrected in LTTng 2.12 were likely present in 
older versions, which are not maintained anymore. All users of 
LTTng-modules and LTTng-UST should upgrade.

* Kernel tracer (LTTng-modules) 2.13.7:

[security] A user belonging to the `tracing` group can use the event 
notification capture or the filtering features to target a userspace 
string (e.g. pathname input field of the openat system call) while any 
user on the system feeds an invalid pointer or a pointer to kernel 
memory to the instrumented system call. This results in a kernel OOPS in 
case of an invalid pointer, or disclosure of kernel memory to the 
tracing group if the pointer targets a kernel memory address. This is 
corrected by properly keeping track of user pointers and using the 
appropriate methods to access userspace memory.

[security] A user belonging to the `tracing` group can use the event 
notification capture or the filtering features to target a userspace 
array of integers (e.g. fildes output field of the pipe2 system call) 
while any user on the system feeds an invalid pointer or a pointer to 
kernel memory to the instrumented system call. This results in a kernel 
OOPS in case of an invalid pointer, or disclosure of kernel memory to 
the tracing group if the pointer targets a kernel memory address. This 
is corrected by properly keeping track of user pointers and using the 
appropriate methods to access userspace memory.

[security] A `tracing` group user crafting an ill-intended event 
notification capture or filter bytecode can emit load and load-field-ref 
instructions which are already specialized for the wrong field type, 
thus bypassing the instruction selection performed by the bytecode 
linker and bytecode specialization phases. When combined with passing 
invalid or kernel memory pointers to userspace memory arguments (e.g. 
pathname input field of openat or fildes output field of pipe2), this 
can result in a kernel OOPS in case of an invalid pointer, or a 
disclosure of kernel memory to the tracing group if the pointer targets 
a kernel memory address. This is corrected by rejecting specialized load 
and load-field-ref instructions in the bytecode validation phase.

Event notification capture fields that end up using more than 512 bytes 
of msgpack buffer space for a single event notification emit warnings in 
the kernel console and result in a corrupted msgpack buffer. This is 
fixed by emitting a "NIL" msgpack field rather than the field that would 
require too much space.

When an event notification capture for a userspace string or a userspace 
integer triggers a page fault, emit a "NIL" msgpack field rather than an 
empty string or a zero-value integer.

Fix a kernel OOPS on powerpc64 when the lttng_tracer module initializes, 
because the do_get_kallsyms LTTng wrapper returns the address of the 
local entry point rather than the global entry point. This is corrected 
by adjusting the offset (+4 and then -4) to get the global entry point 
on PPC64_ELF_ABI_v2.


* Kernel tracer (LTTng-modules) 2.12.11:

[security] A user belonging to the `tracing` group can use the filtering 
feature to target a userspace array of integers (e.g. fildes output 
field of the pipe2 system call) while any user on the system feeds an 
invalid pointer or a pointer to kernel memory to the instrumented system 
call. This results in a kernel OOPS in case of an invalid pointer, or 
disclosure of kernel memory to the tracing group if the pointer targets 
a kernel memory address. This is corrected by properly keeping track of 
user pointers and using the appropriate methods to access userspace memory.

[security] A `tracing` group user crafting an ill-intended filter 
bytecode can emit load and load-field-ref instructions which are already 
specialized for the wrong field type, thus bypassing the instruction 
selection performed by the bytecode linker and bytecode specialization 
phases. When combined with passing invalid or kernel memory pointers to 
userspace memory arguments (e.g. pathname input field of openat or 
fildes output field of pipe2), this can result in a kernel OOPS in case 
of an invalid pointer, or a disclosure of kernel memory to the tracing 
group if the pointer targets a kernel memory address. This is corrected 
by rejecting specialized load and load-field-ref instructions in the 
bytecode validation phase.

Fix a kernel OOPS on powerpc64 when the lttng_tracer module initializes, 
because the do_get_kallsyms LTTng wrapper returns the address of the 
local entry point rather than the global entry point. This is corrected 
by adjusting the offset (+4 and then -4) to get the global entry point 
on PPC64_ELF_ABI_v2.

The filter bytecode interpreter leaves context field byte order 
uninitialized, which can cause erratic filtering behavior when targeting 
context fields. This is not currently observable because current 
lttng-tools do not currently emit BYTECODE_OP_GET_SYMBOL instructions to 
load the context value for filtering. Fix this by initializing the byte 
order field.


* Application tracer (LTTng-UST) 2.13.5:

[security] A `tracing` group user crafting an ill-intended event 
notification capture or filter bytecode can emit load and load-field-ref 
instructions which are already specialized for the wrong field type, 
thus bypassing the instruction selection performed by the bytecode 
linker and bytecode specialization phases. This can result in a 
disclosure of application memory to the tracing group if the type 
expected by the instrumentation is larger than the instrumented type, or 
application crash if a string is expected but the top of interpreter 
stack does not point to a valid address. This is corrected by rejecting 
specialized load and load-field-ref instructions in the bytecode 
validation phase.

Event notification capture fields that end up using more than the number 
of bytes allocated for the msgpack buffer space for a single event 
notification can cause the resulting msgpack buffer to be corrupted. 
This is fixed by emitting a "NIL" msgpack field rather than the field 
that would require too much space.

When getting the shared memory area at initialization time, wait(3) is 
used to wait on the forked child process to exit, which can cause the 
library to wait on any child process of the application. Use waitpid(3) 
instead to make sure the right child is waited for, and therefore don't 
wait for unrelated, unreaped, child processes.


* Application tracer (LTTng-UST) 2.12.7:

[security] A `tracing` group user crafting an ill-intended event 
notification capture or filter bytecode can emit load and load-field-ref 
instructions which are already specialized for the wrong field type, 
thus bypassing the instruction selection performed by the bytecode 
linker and bytecode specialization phases. This can result in a 
disclosure of application memory to the tracing group if the type 
expected by the instrumentation is larger than the instrumented type, or 
application crash if a string is expected but the top of interpreter 
stack does not point to a valid address. This is corrected by rejecting 
specialized load and load-field-ref instructions in the bytecode 
validation phase.

When getting the shared memory area at initialization time, wait(3) is 
used to wait on the forked child process to exit, which can cause the 
library to wait on any child process of the application. Use waitpid(3) 
instead to make sure the right child is waited for, and therefore don't 
wait for unrelated, unreaped, child processes.

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
