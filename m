From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: current_thread_info() not respecting program order with gcc 4.8.x
Date: Fri, 22 Nov 2013 01:34:05 +0100
Message-ID: <528EA67D.5080901@ahsoftware.de>
References: <52803E5D.3050109@mentor.com>	<52851395.3010306@mentor.com>	<67652521.68027.1384482849638.JavaMail.zimbra@efficios.com>	<1691607547.70809.1384874952002.JavaMail.zimbra@efficios.com>	<CA+55aFw923sA0E1RQNxFF0OWFtAfcaG-dBUc-0YYZGDSAsaQyg@mail.gmail.com>	<528E2E8E.8080004@ahsoftware.de>	<CA+55aFyNZun07BLoD2KQFT7cN1xsiQ2gE6hYwRvOGa3tCap4CQ@mail.gmail.com>	<528E94E2.3080102@ahsoftware.de> <CA+55aFx2BTQLFLU0BdXrzYR55SZT_UZ4BjbYoMUZ8bt-p1XENg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFx2BTQLFLU0BdXrzYR55SZT_UZ4BjbYoMUZ8bt-p1XENg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jakub Jelinek <jakub@redhat.com>, Richard Henderson <rth@twiddle.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Peter Zijlstra <peterz@infradead.org>, lttng-dev@lists.lttng.org, Nathan Lynch <Nathan_Lynch@mentor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Luis Lozano <llozano@chromium.org>, Bhaskar Janakiraman <bjanakiraman@chromium.org>, Han Shen <shenhan@chromium.org>
List-Id: lttng-dev@lists.lttng.org

Am 22.11.2013 01:17, schrieb Linus Torvalds:
> On Thu, Nov 21, 2013 at 3:18 PM, Alexander Holler <holler@ahsoftware.de> wrote:

> Basically, your whole argument boils down to "if the function did
> something else than what it does, then it wouldn't be const, so we
> shouldn't mark it const". But that argument is BULLSHIT, because the
> fact is, the function *doesn't* do what you try to claim it does.

Maybe gcc just makes the same false conclusion as I did in my description.

I read it as current_thread_info() returns "a pointer to something 
local" instead of returns "a pointer". Might be BULLSHIT but would 
explain the bug which seems to exist.

Alexander Holler
