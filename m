From: Ilya Mirsky <ilya.mirsky@gmail.com>
Subject: Re: URCU use cases
Date: Thu, 11 Sep 2014 12:22:09 +0300
Message-ID: <CANRvXTO2VvkDfRQACnrFc2eKtAnnWJsKc07-WL=RX-cC1sE5ew__9219.22822385586$1410427507$gmane$org@mail.gmail.com>
References: <CANRvXTM__Z4M2zThuz4+jUUGowd7QFWL79M2gYD9txwcbHZnKA@mail.gmail.com>
 <2038780079.12468624.1410009481977.JavaMail.root@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1258293875=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ilya.mirsky@gmail.com>) id 1XS0ac-0004HZ-SU
 for lttng-dev@lists.lttng.org; Thu, 11 Sep 2014 05:22:57 -0400
Received: by mail-vc0-f177.google.com with SMTP id la4so3279481vcb.22
 for <lttng-dev@lists.lttng.org>; Thu, 11 Sep 2014 02:22:49 -0700 (PDT)
In-Reply-To: <2038780079.12468624.1410009481977.JavaMail.root@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1258293875==
Content-Type: multipart/alternative; boundary=bcaec501676951e32b0502c6b644

--bcaec501676951e32b0502c6b644
Content-Type: text/plain; charset=UTF-8

That's what I thought, thanks for confirming my understanding.
I still miss something about URCU's implementation.
How would a code that operates on multiple structures look like,
as all the api functions are context free (read_lock(), rcu_synchronize(),
etc. have no parameters)?

Thanks,
Ilya

On Sat, Sep 6, 2014 at 4:18 PM, Michel Dagenais <michel.dagenais@polymtl.ca>
wrote:

> Studying the API of URCU it seems that it's mostly intended for link-based
> data structures, such a lists. Suppose I have a large struct that is often
> accessed by many readers, and some writers that occasionally update few
> fields each time. If I understand correctly, using URCU, the writers would
> have to make a copy of the struct on each write, make the changes, and then
> publish the updated version. This is wasteful for small updates to a large
> struct.
>
> RCU / URCU is efficient for read-mostly structures. In that case, copying
> a large struct may not be such a problem since it is infrequent. You also
> have the option of splitting the structure into smaller independently
> updated ones.
>
>

--bcaec501676951e32b0502c6b644
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">That=
&#39;s what I thought, thanks for confirming my understanding.</div><div cl=
ass=3D"gmail_quote">I still miss something about URCU&#39;s implementation.=
</div><div class=3D"gmail_quote">How would a code that operates on multiple=
 structures look like,</div><div class=3D"gmail_quote">as all the api funct=
ions are context free (read_lock(), rcu_synchronize(), etc. have no paramet=
ers)?</div><div class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">=
Thanks,</div><div class=3D"gmail_quote">Ilya</div><div class=3D"gmail_quote=
"><br></div><div class=3D"gmail_quote">On Sat, Sep 6, 2014 at 4:18 PM, Mich=
el Dagenais <span dir=3D"ltr">&lt;<a href=3D"mailto:michel.dagenais@polymtl=
.ca" target=3D"_blank">michel.dagenais@polymtl.ca</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div style=3D"font-family:times new rom=
an,new york,times,serif;font-size:12pt;color:#000000"><span class=3D""><blo=
ckquote style=3D"color:rgb(0,0,0);font-family:Helvetica,Arial,sans-serif;fo=
nt-size:12pt;border-left-width:2px;border-left-style:solid;border-left-colo=
r:rgb(16,16,255);margin-left:5px;padding-left:5px;font-weight:normal;font-s=
tyle:normal;text-decoration:none"><div dir=3D"ltr"><div></div><div>Studying=
 the API of URCU it seems that it&#39;s mostly intended for link-based data=
 structures, such a lists. Suppose I have a large struct that is often acce=
ssed by many readers, and some writers that occasionally update few fields =
each time. If I understand correctly, using URCU, the writers would have to=
 make a copy of the struct on each write, make the changes, and then publis=
h the updated version. This is wasteful for small updates to a large struct=
.</div></div></blockquote></span><font face=3D"Helvetica, Arial, sans-serif=
">RCU / URCU is efficient for read-mostly structures. In that case, copying=
 a large struct may not be such a problem since it is infrequent. You also =
have the option of splitting the structure into smaller independently updat=
ed ones.</font><blockquote style=3D"color:rgb(0,0,0);font-family:Helvetica,=
Arial,sans-serif;font-size:12pt;border-left-width:2px;border-left-style:sol=
id;border-left-color:rgb(16,16,255);margin-left:5px;padding-left:5px;font-w=
eight:normal;font-style:normal;text-decoration:none"><div dir=3D"ltr"><div>=
</div></div></blockquote></div></div></blockquote></div><br></div></div>

--bcaec501676951e32b0502c6b644--


--===============1258293875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1258293875==--
