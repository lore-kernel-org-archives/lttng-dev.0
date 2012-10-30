From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: libust "Error: Error opening shm" every ~4
	seconds	if HOME variable is not set
Date: Mon, 29 Oct 2012 21:42:18 -0400
Message-ID: <20121030014218.GA26711__6240.621492225$1351561383$gmane$org@Krystal>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F843E3@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TT0qS-0000zK-Ro
	for lttng-dev@lists.lttng.org; Mon, 29 Oct 2012 21:42:20 -0400
Content-Disposition: inline
In-Reply-To: <20998D40D9A2B7499CA5A3A2666CB1EB19F843E3@ZURMSG1.QUANTUM.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* David OShea (David.OShea@quantum.com) wrote:
> Hi all,
> 
> I have an application that works as expected when I run it from a shell, but when I start it as a daemon from an init script, it outputs a message like this every 4 or 5 seconds:
> 
> libust[15229/15231]: Error: Error opening shm  (in get_wait_shm() at lttng-ust-comm.c:480)
> 
> I did a little debugging to try and work out what was going on.  I didn't actually end up seeing get_wait_shm() being called, but I noticed that ust_listener_thread() was entering the block of code containing:
> 
> DBG("Info: sessiond not accepting connections to %s apps socket", sock_info->name);
> 
> It appeared that this was because the sock_path was empty.  From looking at sock_info, the wait_shm_path is also empty as shown below, as confirmed in the error message above where "Error opening shm" was meant to be followed by the path that was being opened but instead is just followed by two spaces:
> 
> (gdb) p * (struct sock_info *) arg
> $7 = {name = 0x2b2721bd8b48 "local", ust_listener = 1110300992, root_handle = -1, constructor_sem_posted = 1, allowed = 1, global = 0, sock_path = '\000' <repeats 4095 times>, socket = -1, wait_shm_path = '\000' <repeats 4095 times>, wait_shm_mmap = 0x0}
> 
> setup_local_apps() appears to not fill in the sock_path and wait_shm_path if the HOME environment variable is not set, which is the case for my daemon.  Looking back, I can see that this message appeared during my application's startup:
> 
> libust[15229/15229]: Error: Error setting up to local apps (in lttng_ust_init() at lttng-ust-comm.c:895)
> 
> which is the indicator that setup_local_apps() failed.
> 
> I assume that lttng-ust is attempting to connect to a per-user session daemon, but can't since HOME is not set.  In my case, the application is running as root and connecting to the global session daemon, so I don't mind that it can't connect to a per-user session daemon.  It would be nice if I didn't have to get all of those error messages, although I can certainly ignore them for now and could consider working around them by just making sure HOME is set to something :)
> 
> I'm using lttng-ust-2.0.5 which I have patched with commit 009745db "Cache the procname per-thread rather than per-process to take into account that prctl() can be used to set thread names."

Thanks for reporting! Can you try with stable-2.0 branch or master
branch head ?

Here are the commits:

stable-2.0:

commit e699eda9762d3cf3b0c40329eb3b6ce0947789dc
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Oct 29 21:39:42 2012 -0400

    Cleanup: don't spawn per-user thread if HOME is not set
    
    Reported-by: David OShea <David.OShea@quantum.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

master:

commit 9ec6895c5633ed93c5acdf1e5b06f075fbd709d3
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Oct 29 21:39:42 2012 -0400

    Cleanup: don't spawn per-user thread if HOME is not set
    
    Reported-by: David OShea <David.OShea@quantum.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu


> 
> Thanks in advance,
> David
> 
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
