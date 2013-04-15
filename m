From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Re: Limitations on subbuf_size / num_subbuf?
Date: Mon, 15 Apr 2013 10:23:28 -0400
Message-ID: <516C0D60.1050503__2136.61584207348$1366035888$gmane$org@ericsson.com>
References: <OFC51F8E88.28285A69-ONC2257B4D.003B3B3E-C2257B4D.003B6399@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0185973710=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1URkKO-0003Jx-NQ
	for lttng-dev@lists.lttng.org; Mon, 15 Apr 2013 10:24:16 -0400
In-Reply-To: <OFC51F8E88.28285A69-ONC2257B4D.003B3B3E-C2257B4D.003B6399@il.ibm.com>
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

--===============0185973710==
Content-Type: multipart/alternative;
	boundary="------------090404030708060407070203"

--------------090404030708060407070203
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Not at all a n00b question, but could you give some more info? what is
your version of LTTng tools, are you using UST or kernel tracing? How
much ram is on your system? Kernel version?

I actually have the patched lttng that has standard subbuffer sizes of 4
mb, so I have not personnaly seen that problem. But the first thing I
would do is upgrade to the latest stable.

On 13-04-14 06:49 AM, Amit Margalit wrote:
> Hello,
>
> Sorry for the noob question. I seem to be unable to define the total
> of subbuf_size * num_subbuf higher than 4MB. I am getting ~30%
> discarded tracepoint data.
>
> Any assistance would be greatly appreciated.
>
> Amit Margalit
> IBM XIV - /Storage Reinvented/
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--------------090404030708060407070203
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Not at all a n00b question, but could you give some more info? what
    is your version of LTTng tools, are you using UST or kernel tracing?
    How much ram is on your system? Kernel version? <br>
    <br>
    I actually have the patched lttng that has standard subbuffer sizes
    of 4 mb, so I have not personnaly seen that problem. But the first
    thing I would do is upgrade to the latest stable.<br>
    <br>
    <div class="moz-cite-prefix">On 13-04-14 06:49 AM, Amit Margalit
      wrote:<br>
    </div>
    <blockquote
cite="mid:OFC51F8E88.28285A69-ONC2257B4D.003B3B3E-C2257B4D.003B6399@il.ibm.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <font face="sans-serif" size="2">Hello,</font>
      <br>
      <br>
      <font face="sans-serif" size="2">Sorry for the noob question. I
        seem
        to be unable to define the total of subbuf_size * num_subbuf
        higher than
        4MB. I am getting ~30% discarded tracepoint data.</font>
      <br>
      <br>
      <font face="sans-serif" size="2">Any assistance would be greatly
        appreciated.</font>
      <br>
      <br>
      <font color="#000080" face="sans-serif" size="2">Amit Margalit</font>
      <br>
      <font color="#808000" face="sans-serif" size="2">IBM XIV </font><font
        face="sans-serif" size="2">-
        <i>Storage Reinvented</i></font>
      <br>
      <font face="sans-serif" size="2">XIV-NAS Development Team</font>
      <br>
      <font face="sans-serif" size="2">Tel. 03</font><font face="Arial"
        size="2">-689-7774</font>
      <br>
      <font face="Arial" size="2">Fax. 03-689-7230</font>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------090404030708060407070203--


--===============0185973710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0185973710==--
