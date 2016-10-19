From: Evgeniy Ivanov <i@eivanov.com>
Subject: Re: Deadlock in call_rcu_thread when destroy rculfhash
 node with nested rculfhash
Date: Wed, 19 Oct 2016 13:03:47 +0300
Message-ID: <CAO6Ho0e27-JTmUPrTRZfr95Lm=ri+mOSRNr7Av5Ma0t1ucuH6g__11230.9869066396$1476871445$gmane$org@mail.gmail.com>
References: <CAO6Ho0ea+Mhdoea4b3EL-J4z2wifHPWohq1ps74LQBU+b0-OOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7944426726211218804=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 29F25A0E89
 for <lttng-dev@lists.lttng.org>; Wed, 19 Oct 2016 10:05:50 +0000 (UTC)
Received: by mail-io0-f173.google.com with SMTP id q192so26411919iod.0
 for <lttng-dev@lists.lttng.org>; Wed, 19 Oct 2016 03:03:48 -0700 (PDT)
In-Reply-To: <CAO6Ho0ea+Mhdoea4b3EL-J4z2wifHPWohq1ps74LQBU+b0-OOQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7944426726211218804==
Content-Type: multipart/alternative; boundary=001a113fbb40d78f4d053f34eca5

--001a113fbb40d78f4d053f34eca5
Content-Type: text/plain; charset=UTF-8

Sorry, found partial answer in docs which state that cds_lfht_destroy
should not be called from a call_rcu thread context. Why does this
limitation exists?

On Wed, Oct 19, 2016 at 12:56 PM, Evgeniy Ivanov <i@eivanov.com> wrote:

> Hi,
>
> Each node of top level rculfhash has nested rculfhash. Some thread clears
> the top level map and then uses rcu_barrier() to wait until everything is
> destroyed (it is done to check leaks). Recently it started to dead lock
> sometimes with following stacks:
>
> Thread1:
>
> __poll
> cds_lfht_destroy    <---- nested map
> ...
> free_Node(rcu_head*)  <----- node of top level map
> call_rcu_thread
>
> Thread2:
>
> syscall
> rcu_barrier_qsbr
> destroy_all
> main
>
>
> Did call_rcu_thread dead lock with barrier thread? Or is it some kind of
> internal deadlock because of nested maps?
>
>
> --
> Cheers,
> Evgeniy
>



-- 
Cheers,
Evgeniy

--001a113fbb40d78f4d053f34eca5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sorry, found partial answer in docs which state that=C2=A0=
cds_lfht_destroy should not be called=C2=A0from a call_rcu thread context. =
Why does this limitation exists?</div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Wed, Oct 19, 2016 at 12:56 PM, Evgeniy Ivanov <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:i@eivanov.com" target=3D"_blank">i@eivan=
ov.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"=
ltr">Hi,<br><br>Each node of top level rculfhash has nested rculfhash. Some=
 thread clears the top level map and then uses rcu_barrier() to wait until =
everything is destroyed (it is done to check leaks). Recently it started to=
 dead lock sometimes with following stacks:<br><br>Thread1:<br><font face=
=3D"monospace, monospace"><br></font><div><font face=3D"monospace, monospac=
e">__poll<br>cds_lfht_destroy =C2=A0 =C2=A0&lt;---- nested map<br>...<br>fr=
ee_Node(rcu_head*) =C2=A0&lt;----- node of top level map<br>call_rcu_thread=
<br></font><br>Thread2:<div><br><font face=3D"monospace, monospace">syscall=
 <br>rcu_barrier_qsbr <br>destroy_all<br>main<br></font><br><br>Did=C2=A0ca=
ll_rcu_thread dead lock with barrier thread? Or is it some kind of internal=
 deadlock because of nested maps?<span class=3D"HOEnZb"><font color=3D"#888=
888"><br><br><br>-- <br>Cheers,<br>Evgeniy</font></span></div></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature">Cheers,<br>Evgeniy<=
/div>
</div>

--001a113fbb40d78f4d053f34eca5--

--===============7944426726211218804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7944426726211218804==--
