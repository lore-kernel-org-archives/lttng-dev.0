From: Zheng Da <zhengda1936@gmail.com>
Subject: Re: lttng start error
Date: Thu, 30 May 2013 15:05:47 -0400
Message-ID: <CAFLer8350iF5bCY=jGJVF0Ps=6LQ1yXnkuk29Dtma-zLCgG5mA__39536.0786621042$1369940811$gmane$org@mail.gmail.com>
References: <CAFLer81syvApee-LE=azo25Rs6sq=ktH+PCzU9QCWWP0=KE-AA@mail.gmail.com>
	<CA+jJMxsPP1bx0X9ogssHytV==EFX37irBL-NbBoFO0Q0Tx2hcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zhengda1936@gmail.com>) id 1Ui8Aw-000685-Ni
	for lttng-dev@lists.lttng.org; Thu, 30 May 2013 15:06:14 -0400
Received: by mail-pd0-f182.google.com with SMTP id g10so869010pdj.41
	for <lttng-dev@lists.lttng.org>; Thu, 30 May 2013 12:06:09 -0700 (PDT)
In-Reply-To: <CA+jJMxsPP1bx0X9ogssHytV==EFX37irBL-NbBoFO0Q0Tx2hcg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello,

I built lttng-modules-2.0.6, lttng-tools-2.0.5 and lttng-ust-2.0.6.

Best,
Da

On Thu, May 30, 2013 at 1:14 PM, J=E9r=E9mie Galarneau
<jeremie.galarneau@efficios.com> wrote:
> On Thu, May 30, 2013 at 12:32 PM, Zheng Da <zhengda1936@gmail.com> wrote:
>> Hello,
>>
>> I just started to use lttng. I use Ubuntu 12.04 and the kernel version
>> 3.8.12. I use a customized kernel, so the lttng package in ubuntu
>> can't be installed correctly. I built lttng 2.0 myself.
>
> Did you build only the lttng-modules or the complete toolchain
> (lttng-tools, lttng-ust, lttng-modules)? Which versions of the
> different packages are you using?
>
> Thanks,
> J=E9r=E9mie
>
>>
>> Then I followed the steps in https://lttng.org/quickstart. When I run
>> lttng start, I got the errors:
>> root@ubuntu:~# lttng start
>> PERROR: sendmsg: Bad file descriptor [in lttcomm_send_unix_sock() at
>> sessiond-comm.c:311]
>> PERROR: send consumer channel: Bad file descriptor [in
>> send_kconsumer_session_streams() at main.c:636]
>> PERROR: ioctl start session: No buffer space available [in
>> kernel_start_session() at kernel.c:397]
>> Error: Starting kernel trace failed
>>
>> Someone said in the mailing list that this problem may have something
>> to do with memory limit. But it shouldn't be my case as my machine has
>> 512GB memory.
>>
>> Can anyone help me troubleshoot the problem?
>>
>> Thanks,
>> Da
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
