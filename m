From: Rocky Dunlap via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Large number of stream files in CTF trace -- too
 many file handles
Date: Mon, 16 Mar 2020 21:38:11 -0600
Message-ID: <CADtyBo7J-E0C_Ap-7tztdd-PpHZwDUXBVqkT_mp_O3x9h=Qy5g@mail.gmail.com>
References: <CADtyBo77-N3SscU7K_HCTwVq7+5f_d9yb19buve66p+SrHxVHQ@mail.gmail.com>
 <20200316145125.GC14185@joraj-alpa>
Reply-To: Rocky Dunlap <dunlap@ucar.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6018047994102122938=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by lists.lttng.org (Postfix) with ESMTPS id 48hJmN1wTsz1LLS
 for <lttng-dev@lists.lttng.org>; Mon, 16 Mar 2020 23:38:27 -0400 (EDT)
Received: by mail-ot1-x32e.google.com with SMTP id i12so14967646otp.4
 for <lttng-dev@lists.lttng.org>; Mon, 16 Mar 2020 20:38:27 -0700 (PDT)
In-Reply-To: <20200316145125.GC14185@joraj-alpa>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============6018047994102122938==
Content-Type: multipart/alternative; boundary="0000000000002718b805a104abd0"

--0000000000002718b805a104abd0
Content-Type: text/plain; charset="UTF-8"

Jonathan,

Increasing the soft FD limit worked great, both for the command line and
the Python script.  Thanks for the help!

Rocky

On Mon, Mar 16, 2020 at 8:51 AM Jonathan Rajotte-Julien <
jonathan.rajotte-julien@efficios.com> wrote:

> Hi,
>
> > If this is not the right approach, how should I proceed?  E.g., should
> the
> > source-ctf-fs manage a limited pool of file handles?  I would think this
> > would be pretty inefficient as you would need to constantly open/close
> > files--expensive.
>
> I would probably start looking at the soft and hardlimit for the
> babeltrace2
> process in terms of open file:
>
> On my machine:
>
> joraj@~[]$ ulimit -Sn
> 1024
>
> joraj@~[]$ ulimit -Hn
> 1048576
>
> That is a lot of headspace.
>
> I might have a setting somewhere increasing the base hardlimit but
> in any case you will see how much room you have.
>
> Based on the number of streams you have, I would say that you will
> need more than 2000 as a base soft limit for this trace.
>
> We do have a FD pooling system in place in another project we maintain
> (lttng-tools[1] GPL-2.0) that might be pertinent for babeltrace2 at some
> point
> in time. As for the overhead that would occur in a scenario with not
> enough FD
> available, I think it is a good compromise between either reading a trace
> or
> not reading it at all. A warning informing the user that we reached
> the limit of the pool might be a good start in such case.
>
> [1] https://github.com/lttng/lttng-tools/tree/master/src/common/fd-tracker
>
> Cheers
>
> --
> Jonathan Rajotte-Julien
> EfficiOS
>

--0000000000002718b805a104abd0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Jonathan,<div><br></div><div>Increasing=C2=A0the soft FD l=
imit worked great, both for the command line and the Python script.=C2=A0 T=
hanks for the help!</div><div><br></div><div>Rocky</div></div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 16, 202=
0 at 8:51 AM Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte=
-julien@efficios.com">jonathan.rajotte-julien@efficios.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
&gt; If this is not the right approach, how should I proceed?=C2=A0 E.g., s=
hould the<br>
&gt; source-ctf-fs manage a limited pool of file handles?=C2=A0 I would thi=
nk this<br>
&gt; would be pretty inefficient as you would need to constantly open/close=
<br>
&gt; files--expensive.<br>
<br>
I would probably start looking at the soft and hardlimit for the babeltrace=
2<br>
process in terms of open file:<br>
<br>
On my machine:<br>
<br>
joraj@~[]$ ulimit -Sn<br>
1024<br>
<br>
joraj@~[]$ ulimit -Hn<br>
1048576<br>
<br>
That is a lot of headspace.<br>
<br>
I might have a setting somewhere increasing the base hardlimit but<br>
in any case you will see how much room you have.<br>
<br>
Based on the number of streams you have, I would say that you will<br>
need more than 2000 as a base soft limit for this trace.<br>
<br>
We do have a FD pooling system in place in another project we maintain<br>
(lttng-tools[1] GPL-2.0) that might be pertinent for babeltrace2 at some po=
int<br>
in time. As for the overhead that would occur in a scenario with not enough=
 FD<br>
available, I think it is a good compromise between either reading a trace o=
r<br>
not reading it at all. A warning informing the user that we reached<br>
the limit of the pool might be a good start in such case.<br>
<br>
[1] <a href=3D"https://github.com/lttng/lttng-tools/tree/master/src/common/=
fd-tracker" rel=3D"noreferrer" target=3D"_blank">https://github.com/lttng/l=
ttng-tools/tree/master/src/common/fd-tracker</a><br>
<br>
Cheers<br>
<br>
-- <br>
Jonathan Rajotte-Julien<br>
EfficiOS<br>
</blockquote></div>

--0000000000002718b805a104abd0--

--===============6018047994102122938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6018047994102122938==--
