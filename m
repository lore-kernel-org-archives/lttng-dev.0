From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
Subject: Re: lttng on android
Date: Mon, 21 Jan 2013 10:46:10 -0500
Message-ID: <CA+umk=pZzRFDE9wKLdzJhUKbHoTC50iK=R77BUU_TAroyWwE5Q__37051.869222387$1358783223$gmane$org@mail.gmail.com>
References: <CAHg4Oy8D-TDOkvQV5qpFBfC3RM_=57uwyWD067m2guxaupr-8A@mail.gmail.com>
	<50FD5D83.5070308@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1248052011=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <b0mb00z.it@gmail.com>) id 1TxJZf-0003FK-UC
	for lttng-dev@lists.lttng.org; Mon, 21 Jan 2013 10:46:16 -0500
Received: by mail-vc0-f178.google.com with SMTP id m8so5018493vcd.9
	for <lttng-dev@lists.lttng.org>; Mon, 21 Jan 2013 07:46:10 -0800 (PST)
In-Reply-To: <50FD5D83.5070308@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Matthew Khouzam <matthew.khouzam@ericsson.com>
Cc: Amit Balboul <amit.balboul@shinesec.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1248052011==
Content-Type: multipart/alternative; boundary=20cf307c9d6433d34604d3ce5c3d

--20cf307c9d6433d34604d3ce5c3d
Content-Type: text/plain; charset=ISO-8859-1

We are indeed exploring a few ways to extract the traces through ADB at the
moment, but our work has barely taken off yet; we should have a more solid
grasp on the subject in a few more days. Until then, I believe other
students that are part of this work group are on the mailing list (and they
could have explored the topic a bit more than I did), and might be able to
give you a few more details today or tomorrow.

On Mon, Jan 21, 2013 at 10:23 AM, Matthew Khouzam <
matthew.khouzam@ericsson.com> wrote:

>  I believe a group at l'ecole polytechnique de Montreal is working on
> this, Genvieve, could you please comment more?
>
>
> On 13-01-21 06:48 AM, Amit Balboul wrote:
>
> Hi,
>
>  Is there a way to build the LTTng tools to Android (3.0.31) on ARM ??
>
>  I've managed to compile the modules(2.0.6), put them in the Android
> device and modprobe them.
> Now I would like to extract the traces logs from the device.
> How can I do it ?
> Is there any support for this at all in the LTTng project ?
>
>
>  Thank you for your response !
>
>  Amit.
>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttp://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--20cf307c9d6433d34604d3ce5c3d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

We are indeed exploring a few ways to extract the traces through ADB at the=
 moment, but our work has barely taken off yet; we should have a more solid=
 grasp on the subject in a few more days. Until then, I believe other stude=
nts that are part of this work group are on the mailing list (and they coul=
d have explored the topic a bit more than I did), and might be able to give=
 you a few more details today or tomorrow.<div>
<br><div class=3D"gmail_quote">On Mon, Jan 21, 2013 at 10:23 AM, Matthew Kh=
ouzam <span dir=3D"ltr">&lt;<a href=3D"mailto:matthew.khouzam@ericsson.com"=
 target=3D"_blank">matthew.khouzam@ericsson.com</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">

 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF" text=3D"#000000">
    I believe a group at l&#39;ecole polytechnique de Montreal is working o=
n
    this, Genvieve, could you please comment more?<div><div class=3D"h5"><b=
r>
    <br>
    <div>On 13-01-21 06:48 AM, Amit Balboul
      wrote:<br>
    </div>
    </div></div><blockquote type=3D"cite"><div><div class=3D"h5">
     =20
      <div dir=3D"ltr">Hi,
        <div><br>
        </div>
        <div>Is there a way to build the LTTng tools to Android
          (3.0.31) on ARM ??</div>
        <div><br>
        </div>
        <div>I&#39;ve managed to compile the modules(2.0.6), put
          them in the Android device and modprobe them.</div>
        <div>Now I would like to extract the traces logs from
          the device.</div>
        <div>How can I do it ?</div>
        <div>Is there any support for this at all in the LTTng
          project ?</div>
        <div><br>
        </div>
        <div><br>
        </div>
        <div>Thank you for your response !</div>
        <div><br>
        </div>
        <div>Amit.</div>
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

<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>

--20cf307c9d6433d34604d3ce5c3d--


--===============1248052011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1248052011==--
