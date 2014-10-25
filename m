From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Progress on system crash traces with LTTng using DAX and pmem
Date: Sat, 25 Oct 2014 12:51:25 +0000 (UTC)
Message-ID: <465653369.1985.1414241485934.JavaMail.zimbra@efficios.com>
References: <1254279794.1957.1414240389301.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1254279794.1957.1414240389301.JavaMail.zimbra@efficios.com>
Sender: owner-linux-mm@kvack.org
To: Matthew Wilcox <willy@linux.intel.com>, Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

Hi Matthew, Hi Ross,

A quick follow up on my progress on using DAX and pmem with
LTTng. I've been able to successfully gather a user-space
trace into buffers mmap'd into an ext4 filesystem within
a pmem block device mounted with -o dax to bypass the page
cache. After a soft reboot, I'm able to mount the partition
again, and gather the very last data collected in the buffers
by the applications. I created a "lttng-crash" program that
extracts data from those buffers and converts the content
into a readable Common Trace Format trace. So I guess
you have a use-case for your patchsets on commodity hardware
right there. :)

I've been asked by my customers if DAX would work well with
mtd-ram, which they are using. To you foresee any roadblock
with this approach ?

FYI, the main reason why my customer wants to go with a
"trace into memory that survives soft reboot" approach
rather than to use things like kexec/kdump is that they
care about the amount of time it takes to reboot their
machines. They want a solution where they can extract the
detailed crash data after reboot, after the machine is
back online, rather than requiring a few minutes of offline
time to extract the crash details.

So I guess next year I'll probably be looking into
allocating the LTTng kernel tracer buffers into an mmap'd file
within a ext2/4-DAX-over-pmem/mtd-ram filesystem. It's going
to be exciting! :)

Please keep me in CC on your next patch versions. I'm willing
to spend some more time reviewing them if needed. By the way,
do you guys have a target time-frame/kernel version you aim
at for getting this work upstream ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
