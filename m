From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: Need inputs on LTTng for ARM Linux-3.0.15
Date: Fri, 20 Jul 2012 16:47:46 -0400
Message-ID: <5009C3F2.4050905__18856.8164980554$1342817301$gmane$org@gmail.com>
References: <CALDxG5j7VUTmSf6AYYg_+tTtzi3AbDGwGtCbuO-PPyDJUDkB-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1522966445=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
In-Reply-To: <CALDxG5j7VUTmSf6AYYg_+tTtzi3AbDGwGtCbuO-PPyDJUDkB-A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: srikanth krishnakar <skrishnakar@gmail.com>
Cc: ltt-dev <ltt-dev@lists.casi.polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1522966445==
Content-Type: multipart/alternative;
 boundary="------------010502000900010605070706"

This is a multi-part message in MIME format.
--------------010502000900010605070706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 2012-07-20 14:21, srikanth krishnakar wrote:
> Hello Mathieu,
>
> I am working on LTTng integration for *Linux-3.0.15**ARM v7 Freescale
> i.MX6 SabreLite* target. I previously integrated lttng-modules into
> kernel with while I was working on Linux-2.6.38.
>
> Now I would like to know is there any repository that you are
> maintaining to restore kernel patches for Linux kernel 3.x series ? If
> yes is there any documentation on using those patches against 3.x
> kernel Or should I go with building and installing lttng-modules-2.0.x
> as my only option ?
You can have a look at the LTSI Kernel which include an in tree patchset
for LTTng-modules 2.x
http://ltsi.linuxfoundation.org/downloads


Yannick

--------------010502000900010605070706
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    On 2012-07-20 14:21, srikanth krishnakar wrote:
    <blockquote
cite="mid:CALDxG5j7VUTmSf6AYYg_+tTtzi3AbDGwGtCbuO-PPyDJUDkB-A@mail.gmail.com"
      type="cite">Hello Mathieu,<br>
      <br>
      I am working on LTTng integration for <b
        style="color:rgb(51,51,255)">Linux-3.0.15</b><span
        style="color:rgb(51,51,255)"> </span><b
        style="color:rgb(51,51,255)">ARM v7 Freescale i.MX6 SabreLite</b>
      target. I previously integrated lttng-modules into kernel with
      while I was working on Linux-2.6.38.<br>
      <br>
      Now I would like to know is there any repository that you are
      maintaining to restore kernel patches for Linux kernel 3.x series
      ? If yes is there any documentation on using those patches against
      3.x kernel Or should I go with building and installing
      lttng-modules-2.0.x as my only option ? <br>
    </blockquote>
    You can have a look at the LTSI Kernel which include an in tree
    patchset for LTTng-modules 2.x<br>
    <a class="moz-txt-link-freetext" href="http://ltsi.linuxfoundation.org/downloads">http://ltsi.linuxfoundation.org/downloads</a><br>
    <br>
    <br>
    Yannick<br>
  </body>
</html>

--------------010502000900010605070706--


--===============1522966445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1522966445==--
