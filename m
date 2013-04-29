From: Amit Margalit <AMITM@il.ibm.com>
Subject: Re: Is there a way to make LTTng use the same
 subbuffers for multiple processes?
Date: Mon, 29 Apr 2013 09:00:51 +0300
Message-ID: <OF565A9179.C1F29AC9-ONC2257B5C.0020E852-C2257B5C.0020EF6F__40343.9708556563$1367215333$gmane$org@il.ibm.com>
References: <OFDF63FF91.58AE5030-ONC2257B5B.004BA0B5-C2257B5B.004C083C@il.ibm.com>
	<1871619348.1882721367199149384.JavaMail.root@srv11.zimbra.polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2084951131=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amitm@il.ibm.com>) id 1UWh9i-0007co-Hu
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 02:01:42 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
	Mon, 29 Apr 2013 06:59:52 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
	(d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id D561A219005C
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 07:04:03 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id r3T60s6F38207616
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 06:00:54 GMT
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id r3T4hr2u002319
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 00:43:53 -0400
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
	[9.149.104.181])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with
	ESMTP id r3T4hrgj002315
	for <lttng-dev@lists.lttng.org>; Mon, 29 Apr 2013 00:43:53 -0400
In-Reply-To: <1871619348.1882721367199149384.JavaMail.root@srv11.zimbra.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============2084951131==
Content-Type: multipart/alternative; boundary="=_alternative 0020EF1EC2257B5C_="

This is a multipart message in MIME format.
--=_alternative 0020EF1EC2257B5C_=
Content-Type: text/plain; charset="US-ASCII"

This is excellent. We'll give it a try. Thank you,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230



From:   Michel Dagenais <michel.dagenais@polymtl.ca>
To:     Amit Margalit/Israel/IBM@IBMIL
Cc:     lttng-dev@lists.lttng.org
Date:   04/29/2013 04:32 AM
Subject:        Re: [lttng-dev] Is there a way to make LTTng use the same 
subbuffers for multiple processes?




> Our system is a 12-core x86 (6-core + HT). If I take 4 subbuffers of 
1MB, this means 4MB per
> process. As the number of processes rises, this becomes prohibitive. 
> For example, we may need to support > 500 sub-processes ==> 500 * 4MB = 
2GB - 
> which is a bit too much.  Is there a way to tell LTTng to share the 
sub-buffers with forked processes? 

This is the number one feature listed in the changelog for lttng-tools and 
UST for version 2.2. The first release candidate is out so you can try the 
feature, and the final 2.2 version should not be too far away.

http://lttng.org/lttng-tools-220-rc1
- Add UST per UID buffers support


--=_alternative 0020EF1EC2257B5C_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">This is excellent. We'll give it a try.
Thank you,</font>
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
&nbsp;</font><font size=1 face="sans-serif">Michel Dagenais &lt;michel.dagenais@polymtl.ca&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Amit Margalit/Israel/IBM@IBMIL</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">lttng-dev@lists.lttng.org</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">04/29/2013 04:32 AM</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [lttng-dev]
Is there a way to make LTTng use the same subbuffers for multiple processes?</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3><br>
&gt; </font><font size=2 face="sans-serif">Our system is a 12-core x86
(6-core + HT). If I take 4 subbuffers of 1MB, this means 4MB per<br>
&gt; process. As the number of processes rises, this becomes prohibitive.</font><font size=3>
&nbsp;<br>
&gt; </font><font size=2 face="sans-serif">For example, we may need to
support &gt; 500 sub-processes ==&gt; 500 * 4MB = 2GB - <br>
&gt; which is a bit too much.</font><font size=3> &nbsp;</font><font size=2 face="sans-serif">Is
there a way to tell LTTng to share the sub-buffers with forked processes?</font><font size=3>
<br>
<br>
This is the number one feature listed in the changelog for lttng-tools
and UST for version 2.2. The first release candidate is out so you can
try the feature, and the final 2.2 version should not be too far away.<br>
<br>
</font><a href="http://lttng.org/lttng-tools-220-rc1"><font size=3>http://lttng.org/lttng-tools-220-rc1</font></a><font size=3><br>
- Add UST per UID buffers support<br>
</font>
<br>
--=_alternative 0020EF1EC2257B5C_=--



--===============2084951131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2084951131==--
