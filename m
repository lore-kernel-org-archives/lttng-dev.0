From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: lttng-ust works
Date: Tue, 10 Dec 2013 09:42:45 -0500
Message-ID: <CA+jJMxttkO_TJS+wjBxt8xC3ocXJSTJQRjcqDEYqeOvRREUhHQ__46330.0181356773$1386686624$gmane$org@mail.gmail.com>
References: <6CFA219DE9CAD940989B83CA579159F91B43C4D05A@SGSINEXC014.vestas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1VqOWQ-0005r5-KU
	for lttng-dev@lists.lttng.org; Tue, 10 Dec 2013 09:42:53 -0500
Received: by mail-qe0-f43.google.com with SMTP id 2so4073681qeb.2
	for <lttng-dev@lists.lttng.org>; Tue, 10 Dec 2013 06:42:45 -0800 (PST)
In-Reply-To: <6CFA219DE9CAD940989B83CA579159F91B43C4D05A@SGSINEXC014.vestas.net>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Manikandan Govindaswamy <magov@vestas.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, Dec 10, 2013 at 12:42 AM, Manikandan Govindaswamy
<magov@vestas.com> wrote:
> Hi !,
>
>
>
> I=92m also able to run the easy-ust and generate the traces successfully =
if I
> create and run from an user not as root user.
>
>
>
> But  the kernel traces are generated fine for even root user but for ust =
it
> runs fine only with non-root user in my case.
>
>
>
> And the behavior is vice versa if I try the kernel tracer from user
>

Normal if your user is not part of the "tracing" group.

>
>
> # lttng list -k
>
> Error: Unable to list kernel events: Tracing the kernel requires a root
> lttng-sessiond daemon, as well as "tracing" group membership or root user=
 ID
> for the lttng client.
>
> Error: Command error
>
>
>
> Will it be possible to run both kernel and ust to run and create the trac=
es
> from root user itself? And if you could explain why ust expects the user?
>

There is no reason why you shouldn't be able to generate userspace
traces as root. Let us know what happens when following David's
instructions.

http://lists.lttng.org/pipermail/lttng-dev/2013-December/022110.html

Thanks,
J=E9r=E9mie

>
>
> Regards,
>
> GMK
>
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
