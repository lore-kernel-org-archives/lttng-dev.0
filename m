From: Zheng Da <zhengda1936@gmail.com>
Subject: lttng start error
Date: Thu, 30 May 2013 12:32:36 -0400
Message-ID: <CAFLer81syvApee-LE=azo25Rs6sq=ktH+PCzU9QCWWP0=KE-AA__7962.99026483229$1369931618$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zhengda1936@gmail.com>) id 1Ui5mg-0004rL-6g
	for lttng-dev@lists.lttng.org; Thu, 30 May 2013 12:33:02 -0400
Received: by mail-pd0-f177.google.com with SMTP id u11so649695pdi.8
	for <lttng-dev@lists.lttng.org>; Thu, 30 May 2013 09:32:56 -0700 (PDT)
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

Hello,

I just started to use lttng. I use Ubuntu 12.04 and the kernel version
3.8.12. I use a customized kernel, so the lttng package in ubuntu
can't be installed correctly. I built lttng 2.0 myself.

Then I followed the steps in https://lttng.org/quickstart. When I run
lttng start, I got the errors:
root@ubuntu:~# lttng start
PERROR: sendmsg: Bad file descriptor [in lttcomm_send_unix_sock() at
sessiond-comm.c:311]
PERROR: send consumer channel: Bad file descriptor [in
send_kconsumer_session_streams() at main.c:636]
PERROR: ioctl start session: No buffer space available [in
kernel_start_session() at kernel.c:397]
Error: Starting kernel trace failed

Someone said in the mailing list that this problem may have something
to do with memory limit. But it shouldn't be my case as my machine has
512GB memory.

Can anyone help me troubleshoot the problem?

Thanks,
Da
