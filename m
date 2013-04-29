From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: Is there a way to make LTTng use the same
 subbuffers for multiple processes?
Date: Sun, 28 Apr 2013 21:32:29 -0400 (EDT)
Message-ID: <1871619348.1882721367199149384.JavaMail.root__28584.0225326412$1367199179$gmane$org@srv11.zimbra.polymtl.ca>
References: <OFDF63FF91.58AE5030-ONC2257B5B.004BA0B5-C2257B5B.004C083C@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0119822882=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <michel.dagenais@polymtl.ca>) id 1UWcxF-0005Te-B5
	for lttng-dev@lists.lttng.org; Sun, 28 Apr 2013 21:32:33 -0400
In-Reply-To: <OFDF63FF91.58AE5030-ONC2257B5B.004BA0B5-C2257B5B.004C083C@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0119822882==
Content-Type: multipart/alternative;
	boundary="----=_Part_136306_533564339.1367199149384"

------=_Part_136306_533564339.1367199149384
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


> Our system is a 12-core x86 (6-core + HT). If I take 4 subbuffers of 1MB, this means 4MB per 
> process. As the number of processes rises, this becomes prohibitive. 
> For example, we may need to support > 500 sub-processes ==> 500 * 4MB = 2GB - 
> which is a bit too much. Is there a way to tell LTTng to share the sub-buffers with forked processes? 

This is the number one feature listed in the changelog for lttng-tools and UST for version 2.2. The first release candidate is out so you can try the feature, and the final 2.2 version should not be too far away. 

http://lttng.org/lttng-tools-220-rc1 
- Add UST per UID buffers support 


------=_Part_136306_533564339.1367199149384
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><style type='text/css'>p { margin: 0; }</style></head><body><div style='font-family: Times New Roman; font-size: 12pt; color: #000000'><br>&gt; <font face="sans-serif" size="2">Our system is a 12-core x86 (6-core
+ HT). If I take 4 subbuffers of 1MB, this means 4MB per<br><font size="2">&gt;</font> process. As the
number of processes rises, this becomes prohibitive.</font>&nbsp;
<br>&gt; <font face="sans-serif" size="2">For example, we may need to support
&gt; 500 sub-processes ==&gt; 500 * 4MB = 2GB - <br><font size="2">&gt; </font>which is a bit too much.</font>&nbsp;
<font size="2"><font face="sans-serif"></font></font><font face="sans-serif" size="2">Is there a way to tell LTTng to share
the sub-buffers with forked processes?</font>
<br><br>This is the number one feature listed in the changelog for lttng-tools and UST for version 2.2. The first release candidate is out so you can try the feature, and the final 2.2 version should not be too far away.<br><br>http://lttng.org/lttng-tools-220-rc1<br>- Add UST per UID buffers support<br><br></div></body></html>
------=_Part_136306_533564339.1367199149384--


--===============0119822882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0119822882==--
