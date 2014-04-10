From: Amit Margalit <AMITM@il.ibm.com>
Subject: Babeltrace API question - how can I quickly return to
 rhe first event in the current packet?
Date: Thu, 10 Apr 2014 21:54:03 +0300
Message-ID: <OFA9051451.B0DAB9A8-ONC2257CB6.0067476D-C2257CB6.0067D884__45215.7494881705$1397156129$gmane$org@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0802206847=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <amitm@il.ibm.com>) id 1WYK7D-0003B5-0o
 for lttng-dev@lists.lttng.org; Thu, 10 Apr 2014 14:54:28 -0400
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <lttng-dev@lists.lttng.org> from <amitm@il.ibm.com>;
 Thu, 10 Apr 2014 19:54:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 74DCD2190046
 for <lttng-dev@lists.lttng.org>; Thu, 10 Apr 2014 19:54:07 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3AIsA3K2752804
 for <lttng-dev@lists.lttng.org>; Thu, 10 Apr 2014 18:54:10 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3AIsDrX030366
 for <lttng-dev@lists.lttng.org>; Thu, 10 Apr 2014 12:54:13 -0600
Received: from d06ml311.portsmouth.uk.ibm.com (d06ml311.portsmouth.uk.ibm.com
 [9.149.104.181])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s3AIsDnh030358
 for <lttng-dev@lists.lttng.org>; Thu, 10 Apr 2014 12:54:13 -0600
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multipart message in MIME format.
--===============0802206847==
Content-Type: multipart/alternative; boundary="=_alternative 0067D81FC2257CB6_="

This is a multipart message in MIME format.
--=_alternative 0067D81FC2257CB6_=
Content-Type: text/plain; charset="US-ASCII"

Hello,

I am trying to implement a wrapper to libbabeltrace.so, to provide 
backward iteration capability.

I've already implemented a binary search in lib/iterator.c, in 
seek_file_stream_by_timestamp() - which helps a lot when doing any kind of 
seek. I intend to donate this patch, pretty soon.

However, it seems that the greatest benefit would come from checking 
whether the current event is not the first in its packet, returning 
quickly to the first event in the packet, and then iterating forward until 
we find the event preceding the current one.

Could someone suggest how I would implement such functionality in 
libbabeltrace? I'd be very happy to perform the implementation and donate 
the results, along with performance data.

Thanks,

Amit Margalit
IBM XIV - Storage Reinvented
XIV-NAS Development Team
Tel. 03-689-7774
Fax. 03-689-7230
--=_alternative 0067D81FC2257CB6_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hello,</font>
<br>
<br><font size=2 face="sans-serif">I am trying to implement a wrapper to
libbabeltrace.so, to provide backward iteration capability.</font>
<br>
<br><font size=2 face="sans-serif">I've already implemented a binary search
in lib/iterator.c, in seek_file_stream_by_timestamp() - which helps a lot
when doing any kind of seek. I intend to donate this patch, pretty soon.</font>
<br>
<br><font size=2 face="sans-serif">However, it seems that the greatest
benefit would come from checking whether the current event is not the first
in its packet, returning quickly to the first event in the packet, and
then iterating forward until we find the event preceding the current one.</font>
<br>
<br><font size=2 face="sans-serif">Could someone suggest how I would implement
such functionality in libbabeltrace? I'd be very happy to perform the implementation
and donate the results, along with performance data.</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 color=#000080 face="sans-serif">Amit Margalit</font>
<br><font size=2 color=#808000 face="sans-serif">IBM XIV </font><font size=2 face="sans-serif">-
<i>Storage Reinvented</i></font>
<br><font size=2 face="sans-serif">XIV-NAS Development Team</font>
<br><font size=2 face="sans-serif">Tel. 03</font><font size=2 face="Arial">-689-7774</font>
<br><font size=2 face="Arial">Fax. 03-689-7230</font>
--=_alternative 0067D81FC2257CB6_=--



--===============0802206847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0802206847==--
