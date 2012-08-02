From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [RFC] LTTng address API proposal
Date: Thu, 02 Aug 2012 09:13:30 -0400
Message-ID: <501A7CFA.8000005__23920.9925327033$1343913246$gmane$org@gmail.com>
References: <50180418.5020904@polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0200649592=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SwvDe-0002Fa-8b
	for lttng-dev@lists.lttng.org; Thu, 02 Aug 2012 09:13:38 -0400
Received: by vcbfl11 with SMTP id fl11so9709709vcb.35
	for <lttng-dev@lists.lttng.org>; Thu, 02 Aug 2012 06:13:32 -0700 (PDT)
In-Reply-To: <50180418.5020904@polymtl.ca>
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
--===============0200649592==
Content-Type: multipart/alternative;
 boundary="------------030202090201020309080708"

This is a multi-part message in MIME format.
--------------030202090201020309080708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2012-07-31 12:13, David Goulet wrote:
> This follows the discussion on IRC #lttng which aims at removing the
lttng_uri
> structure from the public API.
>
> Cheers!
> David

> --> lttng_create_session_addr(const char *name, const char *addr,

Why not lttng_create_session_url ?

> PROTO://[HOST|IP][:PORT][/PATH]
>
> Examples:
>
> * net://myhostname
> * net://myhostname:9888
> * net://myhostname/foo/bar
> * net://X.X.X.X:9888/foo/bar


You should put the list of protocol available. Now it seems that we
cannot do file://


> lttng_set_consumer_addr(struct lttng_handle *handle,
                const char *addr);


Can we have examples for the set_consumer addr ?

>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAafOIACgkQFQrZ7GzHX2oKTQCeMZWzl27WI+qEkvik1TorHxtM
RcQAoKZ6wsqNkfNb2WX3jj0Yc2TcPRZ3
=5pn9
-----END PGP SIGNATURE-----


--------------030202090201020309080708
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
    On 2012-07-31 12:13, David Goulet wrote:<br>
    <span style="white-space: pre;">&gt; This follows the discussion on
      IRC #lttng which aims at removing the lttng_uri<br>
      &gt; structure from the public API.<br>
      &gt;<br>
      &gt; Cheers!<br>
      &gt; David<br>
      <br>
      &gt; --&gt; lttng_create_session_addr(const char *name, const char
      *addr,</span><br>
    <br>
    Why not lttng_create_session_url ?<br>
    <br>
    <span style="white-space: pre;">&gt; PROTO://[HOST|IP][:PORT][/PATH]<br>
      &gt; <br>
      &gt; Examples:<br>
      &gt;<br>
      &gt; * <a class="moz-txt-link-freetext" href="net://myhostname">net://myhostname</a><br>
      &gt; * <a class="moz-txt-link-freetext" href="net://myhostname:9888">net://myhostname:9888</a><br>
      &gt; * <a class="moz-txt-link-freetext" href="net://myhostname/foo/bar">net://myhostname/foo/bar</a><br>
      &gt; * <a class="moz-txt-link-freetext" href="net://X.X.X.X:9888/foo/bar">net://X.X.X.X:9888/foo/bar</a></span><br>
    <br>
    <br>
    You should put the list of protocol available. Now it seems that we
    cannot do <a class="moz-txt-link-freetext" href="file://">file://</a><br>
    <br>
    <br>
    <span style="white-space: pre;">&gt; lttng_set_consumer_addr(struct
      lttng_handle *handle,</span><br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *addr);<br>
    <br>
    <br>
    Can we have examples for the set_consumer addr ?<br>
    <br>
    <span style="white-space: pre;">&gt;<br>
      &gt;<br>
      &gt; _______________________________________________<br>
      &gt; lttng-dev mailing list<br>
      &gt; <a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br>
      &gt; <a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a></span><br>
    <br>
    -----BEGIN PGP SIGNATURE-----<br>
    Version: GnuPG v1.4.12 (GNU/Linux)<br>
    Comment: Using GnuPG with Mozilla - <a class="moz-txt-link-freetext" href="http://enigmail.mozdev.org/">http://enigmail.mozdev.org/</a><br>
    <br>
    iEYEARECAAYFAlAafOIACgkQFQrZ7GzHX2oKTQCeMZWzl27WI+qEkvik1TorHxtM<br>
    RcQAoKZ6wsqNkfNb2WX3jj0Yc2TcPRZ3<br>
    =5pn9<br>
    -----END PGP SIGNATURE-----<br>
    <br>
  </body>
</html>

--------------030202090201020309080708--


--===============0200649592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0200649592==--
