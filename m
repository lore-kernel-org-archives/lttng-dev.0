From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Capturing User-Level Function Calls/Returns
Date: Wed, 15 Jul 2020 17:48:58 -0400
Message-ID: <20200715174858.4698803c@oasis.local.home>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
        <20200715142849.0bfe909a@oasis.local.home>
        <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
        <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
Sender: linux-trace-users-owner@vger.kernel.org
To: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-users <linux-trace-users@vger.kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jeremie.galarneau@efficios.com>, Namhyung Kim <namhyung@kernel.org>, linux-trace-users-owner@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

On Thu, 16 Jul 2020 02:09:50 +0430
ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:

> Hi Steven and Mathieu,
> Firstly, many thanks! This method seems to be the most efficient method. 
> But, IIUC, what you suggest requires source code compilation. I need an 
> efficient dynamic method that, given the function address, captures its 
> occurrence and stores some information from the execution context. Is 
> there anything better than Uprobes perhaps with no trap into the kernel? 
> Why do we need traps?
> Regards.

Without recompiling, how would that be implemented?

You would need to insert a jump on top of code, and still be able to
preserve that code. What a trap does, is to insert a int3, that will
trap into the kernel, it would then emulate the code that the int3 was
on, and also call some code that can trace the current state.

To do it in user land, you would need to find way to replace the code
at the location you want to trace, with a jump to the tracing
infrastructure, that will also be able to emulate the code that the
jump was inserted on top of. As on x86, that jump will need to be 5
bytes long (covering 5 bytes of text to emulate), where as a int3 is a
single byte.

Thus, you either recompile and insert nops where you want to place your
jumps, or you trap using int3 that can do the work from within the
kernel.

-- Steve
