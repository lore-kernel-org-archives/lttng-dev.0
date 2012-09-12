From: =?ISO-8859-1?Q?Hans_Nordeb=E4ck?= <hans.nordeback@ericsson.com>
Subject: Problem to get lttng work with a daemon application
Date: Wed, 12 Sep 2012 13:44:19 +0200
Message-ID: <50507593.5030206__49686.1379514032$1347450291$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailgw2.ericsson.se ([193.180.251.37])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <hans.nordeback@ericsson.com>) id 1TBlMj-00026x-BF
	for lttng-dev@lists.lttng.org; Wed, 12 Sep 2012 07:44:21 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi, I've just started using lttng and run it in Ubuntu 12.04 in VirtualBox.

I have run the sample applications without any problem, but I have 
problems to get a daemon application work.

I have added tracepoint support in the same way as for the sample 
applications and do the following:

1) The lttng-sessiond (version 2.0.1) is started (with 
--verbose--verbose-consumer).
2) I start the daemon application with one tracepoint implemented.
3) I can see that the lttng-sessiond gets called regarding this tracepoint:

DEBUG1: App registered with pid:18421 ppid:18419 uid:0 gid:0 sock:18 
name:osafamfnd (version 2.0) [in ust_app_register() at ust-app.c:1365]

4) I run, strace -f lttng -v list -u, and can see that it "hangs" in 
recvmsg:
write(2, "DEBUG1: Getting UST tracing even"..., 81DEBUG1: Getting UST 
tracing events [in list_ust_events() at     commands/list.c:253]
) = 81
getuid()                                = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 3
connect(3, {sa_family=AF_FILE, 
path="/var/run/lttng/client-lttng-sessiond"}, 110) = 0
geteuid()                               = 0
getegid()                               = 0
sendmsg(3, {msg_name(0)=NULL, 
msg_iov(1)=[{"\16\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 
8784}], msg_controllen=28, {cmsg_len=28, cmsg_level=SOL_SOCKET, 
cmsg_type=SCM_CREDENTIALS{pid=28878, uid=0, gid=0}}, msg_flags=0}, 0) = 8784
recvmsg(3,

5) the lttng-sessiond outputs only the following and hangs as long as 
the daemon application is running.
DEBUG1: Processing client command 14 [in process_client_msg() at 
main.c:3309]

6) The only difference between sample app logs and daemon app logs is 
that the pid and ppid seen at DEBUG1: App registered. In the daemon case 
in this run it is pid 18421 ppid 18419 but when I print it in the 
function calling tracepoint
it is pid 18430. I don't know if that is related to the problem. Any 
help on this would be appreciated.

/Thanks Hans
