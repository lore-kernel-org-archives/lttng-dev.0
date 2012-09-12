From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Problem to get lttng work with a daemon application
Date: Wed, 12 Sep 2012 08:41:50 -0400
Message-ID: <20120912124150.GB26893__19474.260582547$1347453751$gmane$org@Krystal>
References: <50507593.5030206@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TBmGN-0002ZS-Gw
	for lttng-dev@lists.lttng.org; Wed, 12 Sep 2012 08:41:51 -0400
Content-Disposition: inline
In-Reply-To: <50507593.5030206@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hans =?iso-8859-1?Q?Nordeb=E4ck?= <hans.nordeback@ericsson.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Hans Nordeb=E4ck (hans.nordeback@ericsson.com) wrote:
> Hi, I've just started using lttng and run it in Ubuntu 12.04 in VirtualBo=
x.
>
> I have run the sample applications without any problem, but I have  =

> problems to get a daemon application work.
>
> I have added tracepoint support in the same way as for the sample  =

> applications and do the following:
>
> 1) The lttng-sessiond (version 2.0.1) is started (with  =


2.0.1 is old. Please upgrade to the latest versions of the 2.0.x series
for both lttng-tools and lttng-ust and try again.

Thanks,

Mathieu

> --verbose--verbose-consumer).
> 2) I start the daemon application with one tracepoint implemented.
> 3) I can see that the lttng-sessiond gets called regarding this tracepoin=
t:
>
> DEBUG1: App registered with pid:18421 ppid:18419 uid:0 gid:0 sock:18  =

> name:osafamfnd (version 2.0) [in ust_app_register() at ust-app.c:1365]
>
> 4) I run, strace -f lttng -v list -u, and can see that it "hangs" in  =

> recvmsg:
> write(2, "DEBUG1: Getting UST tracing even"..., 81DEBUG1: Getting UST  =

> tracing events [in list_ust_events() at     commands/list.c:253]
> ) =3D 81
> getuid()                                =3D 0
> socket(PF_FILE, SOCK_STREAM, 0)         =3D 3
> connect(3, {sa_family=3DAF_FILE,  =

> path=3D"/var/run/lttng/client-lttng-sessiond"}, 110) =3D 0
> geteuid()                               =3D 0
> getegid()                               =3D 0
> sendmsg(3, {msg_name(0)=3DNULL,  =

> msg_iov(1)=3D[{"\16\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\0\0\0\0"..., =

> 8784}], msg_controllen=3D28, {cmsg_len=3D28, cmsg_level=3DSOL_SOCKET,  =

> cmsg_type=3DSCM_CREDENTIALS{pid=3D28878, uid=3D0, gid=3D0}}, msg_flags=3D=
0}, 0) =3D =

> 8784
> recvmsg(3,
>
> 5) the lttng-sessiond outputs only the following and hangs as long as  =

> the daemon application is running.
> DEBUG1: Processing client command 14 [in process_client_msg() at  =

> main.c:3309]
>
> 6) The only difference between sample app logs and daemon app logs is  =

> that the pid and ppid seen at DEBUG1: App registered. In the daemon case  =

> in this run it is pid 18421 ppid 18419 but when I print it in the  =

> function calling tracepoint
> it is pid 18430. I don't know if that is related to the problem. Any  =

> help on this would be appreciated.
>
> /Thanks Hans
>
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
