From: David OShea <David.OShea@quantum.com>
Subject: Wrong procname for userspace trace of app with
 different thread names
Date: Wed, 24 Oct 2012 03:58:59 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F7CBC4__43032.3862740353$1351051178$gmane$org@ZURMSG1.QUANTUM.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=66440f9870=david.oshea@quantum.com>)
	id 1TQs7U-0004FR-Ix
	for lttng-dev@lists.lttng.org; Tue, 23 Oct 2012 23:59:04 -0400
Received: from pps.filterd (m0001158 [127.0.0.1])
	by mx0b-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	q9O3uvFZ001356
	for <lttng-dev@lists.lttng.org>; Tue, 23 Oct 2012 20:59:04 -0700
Received: from ppoxedge1.quantum.com ([146.174.252.27])
	by mx0b-000ceb01.pphosted.com with ESMTP id 185t48h1b6-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Tue, 23 Oct 2012 20:59:04 -0700
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi all,

I performed a userspace trace of a multi-threaded application that uses prctl(PR_SET_NAME, ...) to give its threads names.  From the output of 'lttng view' below (I removed timestamps to make it shorter), it appears that UST is populating the "procname" by getting the process/thread name from the first thread it sees for a given PID, then assuming that name applies to all threads in the process:

mydaemon:22593 mydaemon:start: { <cpu_id> }, { pthread_id = 1496398144, procname = "mythread31", vtid = 22761, vpid = 22593 }, { <payload> }
mydaemon:22593 mydaemon:end: { <cpu_id> }, { pthread_id = 1496398144, procname = "mythread31", vtid = 22761, vpid = 22593 }, { <payload> }
myclient:28277 myclient:end: { <cpu_id> }, { pthread_id = 47216641758592, vtid = 28277, vpid = 28277, procname = "myclient" }, { <payload> }
myclient:28277 myclient:start: { <cpu_id> }, { pthread_id = 47216641758592, vtid = 28277, vpid = 28277, procname = "myclient" }, { <payload> }
mydaemon:22593 mydaemon:start: { <cpu_id> }, { pthread_id = 1485908288, procname = "mythread31", vtid = 22760, vpid = 22593 }, { <payload> }

On the first line, the procname contains the thread name for vtid = 22761.  On the last line, the procname is still shown as "mythread31", but the vtid is different, and I can see from /proc/22593/task/22760/stat that the thread's name is "mythread30".  However, the <process name>:<PID> at the start of each line - the pair before the <trace provider>:<tracepoint name> - does show the actual process name rather than any thread name.

I'm using LTTng 2.0.4 and babeltrace 1.0.0.rc5.  I set up my trace using these steps:

lttng create
lttng enable-channel channel0 --userspace
lttng add-context --userspace -t vpid -t vtid -t procname -t pthread_id
lttng enable-event --userspace --all

It would be great if "procname" was replaced by "threadname" and showed each thread's name correctly, since the process's name is already shown, but the thread names would be very useful.  Otherwise, at the very least, "procname" should probably show the same thing that is shown at the start of the line rather than incorrectly using the name of one of the threads.

Incidentally, why do I have to do "enable-channel" to get the context to actually appear?  If I don't do this, the "add-context" still says that each of the four contexts was "added to all channels", but they don't appear in 'lttng view'.

Thanks in advance,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
