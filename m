From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng Crash seen after stopping the traces.
Date: Mon, 29 Jul 2013 11:35:43 -0400
Message-ID: <CA+jJMxt0kJJv2F26Myzcvms_6tSXAo269Zg5fMXyeXEn5eH95A__38505.1458412365$1375112215$gmane$org@mail.gmail.com>
References: <CAJD=Q56dkx1jCUF0n03XFCs64hFmuDYELy+FVF9joZ8nxDUpDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1V3pUD-0002Ka-85
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 11:35:54 -0400
Received: by mail-wi0-f173.google.com with SMTP id en1so3165703wid.12
	for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2013 08:35:43 -0700 (PDT)
In-Reply-To: <CAJD=Q56dkx1jCUF0n03XFCs64hFmuDYELy+FVF9joZ8nxDUpDw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonnavithula Sharma <sarmajprs@gmail.com>
Cc: lttng-dev@lists.lttng.org, suprasad.desai@gmail.com
List-Id: lttng-dev@lists.lttng.org

Hi,

Can you try to reproduce the problem with the latest version of
lttng-modules (v2.2.1)? There were some bug fixes to the ring buffer
that may correct your problem.

Thanks for reporting,
J=E9r=E9mie

On Mon, Jul 29, 2013 at 9:45 AM, Jonnavithula Sharma
<sarmajprs@gmail.com> wrote:
> Hi
>
> We are currently running lttng on our CPE with 64 MB RAM.We are observing=
 a
> crash after stopping the traces and even if we leave our CPE for few min
> after starting the trace we are observing this crash.Please find the
> attachment for the crash log.
>
> Let us know if any one has faced this issue and your help is highly
> appreciated in resolving this issue.
>
>
> Regards,
> Sarma J
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
