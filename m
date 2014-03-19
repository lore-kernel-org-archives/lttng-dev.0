From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: Performance impact using the "filter" option
Date: Wed, 19 Mar 2014 11:09:42 -0400 (EDT)
Message-ID: <1112565932.1656317.1395241782380.JavaMail.root__14404.053372755$1395241863$gmane$org@polymtl.ca>
References: <OF6F0C7C97.315DE372-ONC2257CA0.00489386-C2257CA0.0048D132@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0245931965=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <michel.dagenais@polymtl.ca>) id 1WQI7y-0005rR-3w
	for lttng-dev@lists.lttng.org; Wed, 19 Mar 2014 11:10:03 -0400
In-Reply-To: <OF6F0C7C97.315DE372-ONC2257CA0.00489386-C2257CA0.0048D132@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: Ilya Mirsky <ilya.mirsky@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0245931965==
Content-Type: multipart/alternative;
	boundary="----=_Part_1656316_1474696337.1395241782379"

------=_Part_1656316_1474696337.1395241782379
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

> If I understand correctly, filtering is done at the client
> application side.

With UST yes. 

> This means that filtering could theoretically lower the performance
> of the running application which has to check, for each event,
> whether it should be sent to the daemon or not.

Each event is checked against the filter and then written to the buffer or not. With a simple filter and most events filtered out, checking the filter is faster than writing to the buffer (with atomic operations to increment the buffer counters) and you definitely save (at each tracepoint and in the daemon with trace buffers filling more slowly). If the filter is complicated and most often keeps the event, then you certainly loose. 

------=_Part_1656316_1474696337.1395241782379
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head><style type='text/css'>p { margin: 0; }</style></head><body><div style='font-family: times new roman,new york,times,serif; font-size: 12pt; color: #000000'><blockquote id="DWT157" style="border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><font face="sans-serif" size="2">If I understand correctly, filtering is
done at the client application side.</font>
<br></blockquote>With UST yes.<br><blockquote id="DWT158" style="border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><font face="sans-serif" size="2">This means that filtering could theoretically
lower the performance of the running application which has to check, for
each event, whether it should be sent to the daemon or not.</font>
<br></blockquote>Each event is checked against the filter and then written to the buffer or not. With a simple filter and most events filtered out, checking the filter is faster than writing to the buffer (with atomic operations to increment the buffer counters) and you definitely save (at each tracepoint and in the daemon with trace buffers filling more slowly). If the filter is complicated and most often keeps the event, then you certainly loose.<br><br></div></body></html>
------=_Part_1656316_1474696337.1395241782379--


--===============0245931965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0245931965==--
