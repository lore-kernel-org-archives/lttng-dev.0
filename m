From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [lttng-tools PATCH] lttng-tools python module
Date: Tue, 31 Jul 2012 15:20:15 -0400
Message-ID: <50182FEF.6070504__3267.63939015127$1343762574$gmane$org@gmail.com>
References: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>
	<50182739.3030604@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1310263038=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yx0-f176.google.com ([209.85.213.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SwHzT-0008D4-4j
	for lttng-dev@lists.lttng.org; Tue, 31 Jul 2012 15:20:23 -0400
Received: by yenl5 with SMTP id l5so7374122yen.35
	for <lttng-dev@lists.lttng.org>; Tue, 31 Jul 2012 12:20:17 -0700 (PDT)
In-Reply-To: <50182739.3030604@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1310263038==
Content-Type: multipart/alternative;
 boundary="------------040600040907010807060303"

This is a multi-part message in MIME format.
--------------040600040907010807060303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2012-07-31 14:43, David Goulet wrote:
>
>
> Apart from those minor issues, I have two questions about this patch.
First,
> why is the python module in src/ and not in extras/ ? I consider src/ to be
> supported and stable code shipped with the installation and/or in packages.
> Also, the src/ directory is the core code of lttng-tools and this module is
> more an extra useful tool.
>
I'm not sure it belongs to extras, since its an actual library that do
something and that is installed on the system.

If you do not want it in src, we could create a top level python
directory or a binding/python (which allows for other language later on).
On the other hand, its a binding of the liblttng-ctl, so having the
binding live with the lib directly can be a good idea.

We should probably do a quick survey of other projects approach.


> Second, _IF_ this goes into src/, please move the tests to the tests/
> directory else we are going to make it self contained in extras/ which
is good
> right now.
>
yes, good point.

Yannick
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAYL+gACgkQFQrZ7GzHX2rtagCgllef/MlyxLacs1Udta3NB8Y5
WJEAnA5E5zMJ08cLdBMYKjsDhqqIF7BP
=j7S+
-----END PGP SIGNATURE-----


--------------040600040907010807060303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    -----BEGIN PGP SIGNED MESSAGE-----<br>
    Hash: SHA1<br>
    <br>
    On 2012-07-31 14:43, David Goulet wrote:<br>
    <span style="white-space: pre;">&gt;<br>
      &gt;<br>
      &gt; Apart from those minor issues, I have two questions about
      this patch. First,<br>
      &gt; why is the python module in src/ and not in extras/ ? I
      consider src/ to be<br>
      &gt; supported and stable code shipped with the installation
      and/or in packages.<br>
      &gt; Also, the src/ directory is the core code of lttng-tools and
      this module is<br>
      &gt; more an extra useful tool.<br>
      &gt;</span><br>
    I'm not sure it belongs to extras, since its an actual library that
    do something and that is installed on the system.<br>
    <br>
    If you do not want it in src, we could create a top level python
    directory or a binding/python (which allows for other language later
    on).<br>
    On the other hand, its a binding of the liblttng-ctl, so having the
    binding live with the lib directly can be a good idea.<br>
    <br>
    We should probably do a quick survey of other projects approach.<br>
    <br>
    <br>
    <span style="white-space: pre;">&gt; Second, _IF_ this goes into
      src/, please move the tests to the tests/<br>
      &gt; directory else we are going to make it self contained in
      extras/ which is good<br>
      &gt; right now.<br>
      &gt;</span><br>
    yes, good point.<br>
    <br>
    Yannick<br>
    -----BEGIN PGP SIGNATURE-----<br>
    Version: GnuPG v1.4.12 (GNU/Linux)<br>
    Comment: Using GnuPG with Mozilla - <a class="moz-txt-link-freetext" href="http://enigmail.mozdev.org/">http://enigmail.mozdev.org/</a><br>
    <br>
    iEYEARECAAYFAlAYL+gACgkQFQrZ7GzHX2rtagCgllef/MlyxLacs1Udta3NB8Y5<br>
    WJEAnA5E5zMJ08cLdBMYKjsDhqqIF7BP<br>
    =j7S+<br>
    -----END PGP SIGNATURE-----<br>
    <br>
  </body>
</html>

--------------040600040907010807060303--


--===============1310263038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1310263038==--
