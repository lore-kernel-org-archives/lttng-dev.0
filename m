From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: LTTng
Date: Fri, 20 Jul 2012 13:43:59 -0400
Message-ID: <500998DF.30106__46549.8365498663$1342806335$gmane$org@gmail.com>
References: <C3E76F4DB674C24BA475182F42DDE8B54E5ACE@SOM-EXCH02.nuance.com>
	<5009718E.8020308@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0954420818=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f48.google.com ([209.85.213.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SsHFI-0008H0-RJ
	for lttng-dev@lists.lttng.org; Fri, 20 Jul 2012 13:44:09 -0400
Received: by yhfq46 with SMTP id q46so5038090yhf.35
	for <lttng-dev@lists.lttng.org>; Fri, 20 Jul 2012 10:44:03 -0700 (PDT)
In-Reply-To: <5009718E.8020308@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Alawneh,
	Luay" <Luay.Alawneh@nuance.com>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0954420818==
Content-Type: multipart/alternative;
 boundary="------------020707020407080104080702"

This is a multi-part message in MIME format.
--------------020707020407080104080702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

UST could work for your logging purpose, but one drag back is that
you'll need to have a session daemon running, which will spawn a
consumer. You will also need to manage the start/stop of the tracing.

Yannick

On 2012-07-20 10:56, David Goulet wrote:
> Hi Luay,
>
> I am not aware of any Log4c --> LTTng transition work done up to this
> day...
>
> One thing I can say is that user space tracing using LTTng will
> certainly improve speed and scalability performance.
>
> The event LOGLEVEL feature is pretty interesting for that where you
> can only enable a certain loglevel facility for a trace (exactly like
> the syslog facilities). You can refer to the lttng-ust(3) man page for
> more information.
>
> Moreover, you can also couple kernel traces to your user space traces
> which can give you way more information :).
>
> I guess that if now one replies to this thread describing their
> experience with log4c vs lttng, you guys will be the first to try a
> transition and we will be more than happy to help you with any bugs or
> difficulties you'll encounter :)
>
> Moreover, if you are able to come up with some sort of scripts/recipe
> for that, it will be the kind of documentation or tool that could
> benefit big time the community! :)
>
> Feel free to ask on the mailing list any concerns/questions/comments
> you have.
>
> Cheers!
> David
>
> Alawneh, Luay:
> > Hi,
>
>
>
> > I am reading about LTTng and I would like to know if it can
> > replace Log4c for logging user space events in the production
> > environment. In addition to the method enter/exit events we also
> > use Log4c to log many other events to indicate errors and other
> > useful information.
>
>
>
> > To summarize, I would like to know if LTTng can be used in a
> > production environment for logging different types of events. We
> > are planning to replace Log4c with another logging framework to
> > improve the performance by reducing the time spent in logging.
>
>
>
> > Thanks,
>
>
>
> > Luay Alawneh
>
> > Nuance Communications
>
>
>
>
>
> > This body part will be downloaded on demand.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAJmNUACgkQFQrZ7GzHX2pCUQCfZDF5c6Bl+ums2gf3CfsBUxnB
pIYAn3KCWayyKnQDkqM/88663iWeFHFH
=z4nw
-----END PGP SIGNATURE-----


--------------020707020407080104080702
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
    Hi,<br>
    <br>
    UST could work for your logging purpose, but one drag back is that
    you'll need to have a session daemon running, which will spawn a
    consumer. You will also need to manage the start/stop of the
    tracing.<br>
    <br>
    Yannick<br>
    <br>
    On 2012-07-20 10:56, David Goulet wrote:<br>
    <span style="white-space: pre;">&gt; Hi Luay,<br>
      &gt;<br>
      &gt; I am not aware of any Log4c --&gt; LTTng transition work done
      up to this<br>
      &gt; day...<br>
      &gt;<br>
      &gt; One thing I can say is that user space tracing using LTTng
      will<br>
      &gt; certainly improve speed and scalability performance.<br>
      &gt;<br>
      &gt; The event LOGLEVEL feature is pretty interesting for that
      where you<br>
      &gt; can only enable a certain loglevel facility for a trace
      (exactly like<br>
      &gt; the syslog facilities). You can refer to the lttng-ust(3) man
      page for<br>
      &gt; more information.<br>
      &gt;<br>
      &gt; Moreover, you can also couple kernel traces to your user
      space traces<br>
      &gt; which can give you way more information :).<br>
      &gt;<br>
      &gt; I guess that if now one replies to this thread describing
      their<br>
      &gt; experience with log4c vs lttng, you guys will be the first to
      try a<br>
      &gt; transition and we will be more than happy to help you with
      any bugs or<br>
      &gt; difficulties you'll encounter :)<br>
      &gt;<br>
      &gt; Moreover, if you are able to come up with some sort of
      scripts/recipe<br>
      &gt; for that, it will be the kind of documentation or tool that
      could<br>
      &gt; benefit big time the community! :)<br>
      &gt;<br>
      &gt; Feel free to ask on the mailing list any
      concerns/questions/comments<br>
      &gt; you have.<br>
      &gt;<br>
      &gt; Cheers!<br>
      &gt; David<br>
      &gt;<br>
      &gt; Alawneh, Luay:<br>
      &gt; &gt; Hi,<br>
      &gt;<br>
      &gt;<br>
      &gt;<br>
      &gt; &gt; I am reading about LTTng and I would like to know if it
      can<br>
      &gt; &gt; replace Log4c for logging user space events in the
      production<br>
      &gt; &gt; environment. In addition to the method enter/exit events
      we also<br>
      &gt; &gt; use Log4c to log many other events to indicate errors
      and other<br>
      &gt; &gt; useful information.<br>
      &gt;<br>
      &gt;<br>
      &gt;<br>
      &gt; &gt; To summarize, I would like to know if LTTng can be used
      in a<br>
      &gt; &gt; production environment for logging different types of
      events. We<br>
      &gt; &gt; are planning to replace Log4c with another logging
      framework to<br>
      &gt; &gt; improve the performance by reducing the time spent in
      logging.<br>
      &gt;<br>
      &gt;<br>
      &gt;<br>
      &gt; &gt; Thanks,<br>
      &gt;<br>
      &gt;<br>
      &gt;<br>
      &gt; &gt; Luay Alawneh<br>
      &gt;<br>
      &gt; &gt; Nuance Communications<br>
      &gt;<br>
      &gt;<br>
      &gt;<br>
      &gt;<br>
      &gt;<br>
      &gt; &gt; This body part will be downloaded on demand.<br>
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
    iEYEARECAAYFAlAJmNUACgkQFQrZ7GzHX2pCUQCfZDF5c6Bl+ums2gf3CfsBUxnB<br>
    pIYAn3KCWayyKnQDkqM/88663iWeFHFH<br>
    =z4nw<br>
    -----END PGP SIGNATURE-----<br>
    <br>
  </body>
</html>

--------------020707020407080104080702--


--===============0954420818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0954420818==--
