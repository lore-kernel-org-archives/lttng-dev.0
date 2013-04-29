From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: Is there a way to make LTTng use the same
 subbuffers for multiple processes?
Date: Mon, 29 Apr 2013 12:08:23 -0400 (EDT)
Message-ID: <1506315467.1950571367251703283.JavaMail.root__29580.7803785012$1367251740$gmane$org@srv11.zimbra.polymtl.ca>
References: <1704772455.1950411367251637542.JavaMail.root@srv11.zimbra.polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0695822539=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <michel.dagenais@polymtl.ca>) id 1UWqcu-0004Bx-1a
	for lttng-dev@lists.lttng.org; Mon, 29 Apr 2013 12:08:28 -0400
In-Reply-To: <1704772455.1950411367251637542.JavaMail.root@srv11.zimbra.polymtl.ca>
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

--===============0695822539==
Content-Type: multipart/alternative;
	boundary="----=_Part_141368_639722107.1367251703283"

------=_Part_141368_639722107.1367251703283
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


> Another 2.2 question - 
> What if I have a single process, that forks, and each child process then changes its own UID. 
> Will the tracing continue on the parent UID buffers? 

The parent is running as root and the child processes are using seteuid? I am not sure about how this is handled. David or Mathieu can tell you more about the new architecture for sharing buffers. 

------=_Part_141368_639722107.1367251703283
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><style type='text/css'>p { margin: 0; }</style></head><body><div style='font-family: Times New Roman; font-size: 12pt; color: #000000'><br>&gt; <font face="sans-serif" size="2">Another 2.2 question -</font>
<br>&gt; <font face="sans-serif" size="2">What if I have a single process, that
forks, and each child process then changes its own UID. <br><font size="2">&gt; </font>Will the tracing
continue on the parent UID buffers?</font>
<br><br>The parent is running as root and the child processes are using seteuid? I am not sure about how this is handled. David or Mathieu can tell you more about the new architecture for sharing buffers.<br></div></body></html>
------=_Part_141368_639722107.1367251703283--


--===============0695822539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0695822539==--
