From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: auto generation of .c and .h files for a userspace
	app
Date: Wed, 11 Dec 2013 09:44:43 +0200
Message-ID: <OF99441400.97CB7A5A-ONC2257C3E.002A85FC-C2257C3E.002A8E95__47893.9719418578$1386748007$gmane$org@il.ibm.com>
References: <CAM5kDqwv-9ctjTaHsGyQVhPwmLooCv+U7eUNt=ggRnunqvdDBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1906558726=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1VqeU3-0005Vk-Az
	for lttng-dev@lists.lttng.org; Wed, 11 Dec 2013 02:45:32 -0500
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Wed, 11 Dec 2013 07:45:21 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
	(d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3C5051B08066
	for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2013 07:44:24 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id rBB7iiH740108216
	for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2013 07:45:06 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id rBB7iu2V007039
	for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2013 00:44:56 -0700
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with
	ESMTP id rBB7iuNZ007031
	for <lttng-dev@lists.lttng.org>; Wed, 11 Dec 2013 00:44:56 -0700
In-Reply-To: <CAM5kDqwv-9ctjTaHsGyQVhPwmLooCv+U7eUNt=ggRnunqvdDBQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============1906558726==
Content-Type: multipart/alternative; boundary="=_alternative 002A8E63C2257C3E_="

This is a multipart message in MIME format.
--=_alternative 002A8E63C2257C3E_=
Content-Type: text/plain; charset="US-ASCII"

I refer you to this correspondence: 
http://lists.lttng.org/pipermail/lttng-dev/2013-July/020859.html 

I hope it helps.

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Anand Neeli <anand.neeli@gmail.com>
To:     lttng-dev@lists.lttng.org
Date:   12/11/2013 07:33 AM
Subject:        [lttng-dev] auto generation of .c and .h files for a 
userspace app



Hi All,

Is there a script/program which can be used to auto-generate the required 
.c and .h files required for lttng-ust. 
The script/program should parse all the .c files in a directory and 
generate corresponding .c and .h files. And this should be run before the 
build of app.

This would make app developers life easy and will be very useful for on 
the fly changes.

Will be great if someone can all add more details related to this topic or 
give me pointers if this is already discussed.

Thanks,
Anand Neeli_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=_alternative 002A8E63C2257C3E_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">I refer you to this correspondence: </font><a href="http://lists.lttng.org/pipermail/lttng-dev/2013-July/020859.html"><font size=3 color=blue><u>http://lists.lttng.org/pipermail/lttng-dev/2013-July/020859.html</u></font></a><font size=3>
</font>
<br>
<br><font size=2 face="sans-serif">I hope it helps.</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Anand Neeli &lt;anand.neeli@gmail.com&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">12/11/2013 07:33 AM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">[lttng-dev]
auto generation of .c and .h files for a userspace app</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3>Hi All,</font>
<br>
<br><font size=3>Is there a script/program which can be used to auto-generate
the required .c and .h files required for lttng-ust.&nbsp;</font>
<br><font size=3>The script/program should parse all the .c files in a
directory and generate corresponding .c and .h files. And this should be
run before the build of app.</font>
<br>
<br><font size=3>This would make app developers life easy and will be very
useful for on the fly changes.</font>
<br>
<br><font size=3>Will be great if someone can all add more details related
to this topic or give me pointers if this is already discussed.</font>
<br>
<br><font size=3>Thanks,</font>
<br><font size=3>Anand Neeli</font><tt><font size=2>_______________________________________________<br>
lttng-dev mailing list<br>
lttng-dev@lists.lttng.org<br>
</font></tt><a href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"><tt><font size=2>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</font></tt></a><tt><font size=2><br>
</font></tt>
<br>
--=_alternative 002A8E63C2257C3E_=--



--===============1906558726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1906558726==--
