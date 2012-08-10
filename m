From: Paul Barrette <paulbarrette@gmail.com>
Subject: Re: qemuarm: Session dameon died (exit status 0)
Date: Fri, 10 Aug 2012 10:40:03 -0400
Message-ID: <CAKe51+2cNmVj7tjdtUwPJ2cuG=Rsa3qKKFGjV1JNL6_vBZY_1A__3789.43923064998$1344609669$gmane$org@mail.gmail.com>
References: <CAKe51+3mCaia8a--vH8KVbtA+kkzGsKx2=C0-K1qEvNY42wRkQ@mail.gmail.com>
	<50251B38.8040205@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0362253715=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f176.google.com ([74.125.82.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <paulbarrette@gmail.com>) id 1SzqNl-0005SP-Hk
	for lttng-dev@lists.lttng.org; Fri, 10 Aug 2012 10:40:10 -0400
Received: by weyu3 with SMTP id u3so1214857wey.35
	for <lttng-dev@lists.lttng.org>; Fri, 10 Aug 2012 07:40:03 -0700 (PDT)
In-Reply-To: <50251B38.8040205@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0362253715==
Content-Type: multipart/alternative; boundary=20cf30207fc4c796e504c6ea5185

--20cf30207fc4c796e504c6ea5185
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 10, 2012 at 10:31 AM, Yannick Brosseau <
yannick.brosseau@gmail.com> wrote:

>  Hi,
>
> Can you try to start the lttng-sessiond manually and see if there is erro=
r
> message (with full logging enabled: lttng-sessiond -vvv)
>
> Hi,
# lttng-sessiond -ww
Segmentation fault.


Pb

> Yannick
>
>
> On 2012-08-10 10:02, Paul Barrette wrote:
>
> Hi all,
> lttng-modules 2.0.4
> lttng-tools 2.0.4
> linux kernel 3.4.x
>
>  I am running  qemuarm and seeing the following issue when running "lttng
> create":
> Error: Session daemon died (exit status 0)
>
>  Is there a patch I am missing for arm?
>
>  Thanks
> Pb
>
>  --
> --
> Paul Barrette
> Linked In Profile <http://ca.linkedin.com/pub/paul-barrette/11/b42/a96>
> http://sitarplayer.net
> =C5=90
>  \\=3D^%
>  (*)---(*)
> ^^~~^~~~^^^~~^
>
>
>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttp://lists.lttng.org/cgi=
-bin/mailman/listinfo/lttng-dev
>
>
>


--=20
--
Paul Barrette
Linked In Profile <http://ca.linkedin.com/pub/paul-barrette/11/b42/a96>
http://sitarplayer.net
=C5=90
 \\=3D^%
 (*)---(*)
^^~~^~~~^^^~~^

--20cf30207fc4c796e504c6ea5185
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Aug 10, 2012 at 10:31 AM, Yannic=
k Brosseau <span dir=3D"ltr">&lt;<a href=3D"mailto:yannick.brosseau@gmail.c=
om" target=3D"_blank">yannick.brosseau@gmail.com</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">

 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000">
    Hi,<br>
    <br>
    Can you try to start the lttng-sessiond manually and see if there is
    error message (with full logging enabled: lttng-sessiond -vvv)<br>
    <br></div></blockquote><div>Hi,</div><div># lttng-sessiond -ww</div><di=
v>Segmentation fault.</div><div><br></div><div>=C2=A0</div><div>Pb</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
<div bgcolor=3D"#FFFFFF" text=3D"#000000">
    Yannick<div><div class=3D"h5"><br>
    <br>
    On 2012-08-10 10:02, Paul Barrette wrote:
    </div></div><blockquote type=3D"cite"><div><div class=3D"h5">Hi all,
      <div>lttng-modules 2.0.4</div>
      <div>lttng-tools 2.0.4</div>
      <div>linux kernel 3.4.x</div>
      <div><br>
      </div>
      <div>I am running =C2=A0qemuarm and seeing the following issue when
        running &quot;lttng create&quot;:</div>
      <div>Error: Session daemon died (exit status 0)</div>
      <div><br>
      </div>
      <div>Is there a patch I am missing for arm?</div>
      <div><br>
      </div>
      <div>Thanks</div>
      <div>Pb<br clear=3D"all">
        <div><br>
        </div>
        -- <br>
        --<br>
        Paul Barrette<br>
        <a href=3D"http://ca.linkedin.com/pub/paul-barrette/11/b42/a96" tar=
get=3D"_blank">Linked In Profile</a><br>
        <a href=3D"http://sitarplayer.net" target=3D"_blank">http://sitarpl=
ayer.net</a><br>
        <font face=3D"verdana"><font color=3D"black"><font>=C5=90</font></f=
ont></font>
        <br>
        <font face=3D"verdana"><font color=3D"black"><font>=C2=A0\\=3D^% <b=
r>
              =C2=A0(*)---(*)</font></font></font> <br>
        <font face=3D"courier new">^^~~^~~~^^^~~^</font>
        <div style=3D"text-align:left"><br>
        </div>
        <br>
      </div>
      <br>
      <fieldset></fieldset>
      <br>
      </div></div><pre>_______________________________________________
lttng-dev mailing list
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </div>

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>--<br>Paul B=
arrette<br><a href=3D"http://ca.linkedin.com/pub/paul-barrette/11/b42/a96" =
target=3D"_blank">Linked In Profile</a><br><a href=3D"http://sitarplayer.ne=
t" target=3D"_blank">http://sitarplayer.net</a><br>
<font face=3D"verdana"><font color=3D"black"><font>=C5=90</font></font></fo=
nt>  <br>

<font face=3D"verdana"><font color=3D"black"><font>=C2=A0\\=3D^%  <br>=C2=
=A0(*)---(*)</font></font></font> <br>
 <font face=3D"courier new">^^~~^~~~^^^~~^</font><div style=3D"text-align:l=
eft"><br></div><br>

--20cf30207fc4c796e504c6ea5185--


--===============0362253715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0362253715==--
