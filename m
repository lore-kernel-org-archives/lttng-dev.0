From: =?UTF-8?Q?Adrien_Verg=C3=A9?= <adrienverge@gmail.com>
Subject: Re: [PATCH lttng-ust] Fix linking failure when
	cross-compiling
Date: Sat, 26 Apr 2014 12:23:09 -0400
Message-ID: <CANsc=4Xh67Jnuy1b9eqirHNVGERa+ugVEdzkU0Yy652a+Nw5PA__8472.60322557322$1398529463$gmane$org@mail.gmail.com>
References: <1398442344-15165-1-git-send-email-adrienverge@gmail.com>
 <1751778549.7675.1398501609681.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1234340483=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <adrienverge@gmail.com>) id 1We5Nj-0006fw-5J
 for lttng-dev@lists.lttng.org; Sat, 26 Apr 2014 12:23:19 -0400
Received: by mail-ve0-f171.google.com with SMTP id jy13so6054486veb.2
 for <lttng-dev@lists.lttng.org>; Sat, 26 Apr 2014 09:23:09 -0700 (PDT)
In-Reply-To: <1751778549.7675.1398501609681.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1234340483==
Content-Type: multipart/alternative; boundary=047d7b676da478a21704f7f47fd1

--047d7b676da478a21704f7f47fd1
Content-Type: text/plain; charset=UTF-8

2014-04-26 4:40 GMT-04:00 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
:

> It should change much things overall, but is there any reason for
> this change ?
>

Actually my first plan was to remove all trailing slashes, then I changed
my mind to change as little code as possible. But oops... forgot one slash
:)

Please tell me if I should resend a v2 patch with (or without) trailing
slashes.

Thanks,

Adrien

--047d7b676da478a21704f7f47fd1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">2014-04-26 4:40 GMT-04:00 Mathieu Desnoyers <span dir=3D"l=
tr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank"=
>mathieu.desnoyers@efficios.com</a>&gt;</span>:<br><div class=3D"gmail_extr=
a"><div class=3D"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
It should change much things overall, but is there any reason for<br>
this change ?<br></blockquote><div><br></div>Actually my first plan was to =
remove all trailing slashes, then I changed my mind to change as little cod=
e as possible. But oops... forgot one slash :)<div><br></div><div>Please te=
ll me if I should resend a v2 patch with (or without) trailing slashes.</di=
v>
<div><br></div><div>Thanks,</div><div><br></div><div>Adrien</div></div></di=
v></div>

--047d7b676da478a21704f7f47fd1--


--===============1234340483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1234340483==--
