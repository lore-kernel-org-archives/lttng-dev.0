From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien+lttng@versatic.net>
Subject: Experimental ready-to-use TMF
Date: Fri, 18 Oct 2013 14:30:43 -0400
Message-ID: <52617E53.2040505__11512.8893907697$1382121109$gmane$org@versatic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1501284136=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1VXEou-0000GM-Lz
	for lttng-dev@lists.lttng.org; Fri, 18 Oct 2013 14:30:50 -0400
Received: from [132.207.169.211] ([132.207.169.211])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id r9IIUhFn004493
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Fri, 18 Oct 2013 14:30:44 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============1501284136==
Content-Type: multipart/alternative;
 boundary="------------000006090204060208090008"

This is a multi-part message in MIME format.
--------------000006090204060208090008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id r9IIUhFn004493
Content-Transfer-Encoding: quoted-printable

Hi all,

Here at =C9cole Polytechnique, many people are working on new features fo=
r=20
the Eclipse viewer (TMF): some are prototypes, some are under review for=20
inclusion in coming releases.  I'm keeping a branch of all the students'=20
work until they are accepted into TMF.  It is experimental, the code is=20
not necessarily "clean", it may eat up all your java memory, it may=20
throw exceptions, but it is there to test.

Git branch:=20
http://git.dorsal.polymtl.ca/~gbastien?p=3Dlinuxtools-tmf.git;a=3Dshortlo=
g;h=3Drefs/heads/luna_dorsal=20
<http://git.dorsal.polymtl.ca/%7Egbastien?p=3Dlinuxtools-tmf.git;a=3Dshor=
tlog;h=3Drefs/heads/luna_dorsal>

And thanks to the TMF team's effort to bring TMF to the still nameless=20
non-Eclipse Rich Client Platform (aka traceviewer), these features we're=20
working on are now one archive away from your mouse pointer.  Just=20
download the archive for your system, extract it, cd to the traceviewer=20
directory, execute traceViewer and voil=E0!

Ready-to-use archives:=20
http://secretaire.dorsal.polymtl.ca/~gbastien/TracingRCP/=20
<http://secretaire.dorsal.polymtl.ca/%7Egbastien/TracingRCP/>

See the readme for documentation on available features, how to use them=20
and how to get examples

As of now, the new analysis are:

1- Lttng kernel trace execution graph and critical path computation
2- Xml-defined state systems and views
3- Virtual Machines experiments

Feedback are welcome and enjoy!

Genevi=E8ve Bastien

--------------000006090204060208090008
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi all,<br>
    <br>
    Here at &Eacute;cole Polytechnique, many people are working on new features
    for the Eclipse viewer (TMF): some are prototypes, some are under
    review for inclusion in coming releases.&nbsp; I'm keeping a branch of
    all the students' work until they are accepted into TMF.&nbsp; It is
    experimental, the code is not necessarily "clean", it may eat up all
    your java memory, it may throw exceptions, but it is there to test.<br>
    <br>
    Git branch: <a
href="http://git.dorsal.polymtl.ca/%7Egbastien?p=linuxtools-tmf.git;a=shortlog;h=refs/heads/luna_dorsal">http://git.dorsal.polymtl.ca/~gbastien?p=linuxtools-tmf.git;a=shortlog;h=refs/heads/luna_dorsal</a><br>
    <br>
    And thanks to the TMF team's effort to bring TMF to the still
    nameless non-Eclipse Rich Client Platform (aka traceviewer), these
    features we're working on are now one archive away from your mouse
    pointer.&nbsp; Just download the archive for your system, extract it, cd
    to the traceviewer directory, execute traceViewer and voil&agrave;!<br>
    <br>
    Ready-to-use archives: <a
      href="http://secretaire.dorsal.polymtl.ca/%7Egbastien/TracingRCP/">http://secretaire.dorsal.polymtl.ca/~gbastien/TracingRCP/</a><br>
    <br>
    See the readme for documentation on available features, how to use
    them and how to get examples<br>
    <br>
    As of now, the new analysis are:<br>
    <br>
    1- Lttng kernel trace execution graph and critical path computation<br>
    2- Xml-defined state systems and views<br>
    3- Virtual Machines experiments<br>
    <br>
    Feedback are welcome and enjoy!<br>
    <br>
    Genevi&egrave;ve Bastien
  </body>
</html>

--------------000006090204060208090008--


--===============1501284136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1501284136==--
