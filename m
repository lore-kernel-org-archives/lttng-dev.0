From: =?ISO-8859-1?Q?Genevi=E8ve_Bastien?= <gbastien+lttng@versatic.net>
Subject: Re: New LTTNG user
Date: Thu, 27 Jun 2013 10:22:08 -0400
Message-ID: <51CC4A90.4070902__36778.2732857906$1372342964$gmane$org@versatic.net>
References: <CAPxN80A4-Fa3hhA8+zmmckhwRrp0qb2+xXcebw8tmB1QXGULzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0057655171=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <gbastien+lttng@versatic.net>) id 1UsD5N-0001r5-Sp
	for lttng-dev@lists.lttng.org; Thu, 27 Jun 2013 10:22:09 -0400
Received: from [132.207.169.211] ([132.207.169.211])
	by smtp.polymtl.ca (8.14.3/8.14.3) with ESMTP id r5REM8TK020832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Thu, 27 Jun 2013 10:22:09 -0400
In-Reply-To: <CAPxN80A4-Fa3hhA8+zmmckhwRrp0qb2+xXcebw8tmB1QXGULzw@mail.gmail.com>
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
--===============0057655171==
Content-Type: multipart/alternative;
 boundary="------------020702080508060705000406"

This is a multi-part message in MIME format.
--------------020702080508060705000406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id r5REM8TK020832

On 06/26/2013 12:58 AM, Jessica Foest wrote:
> Hi
>
> when use lttng network tracepoint it didn't display network interface=20
> mode (like promiscuous mode or other ) . did i miss some tracepoint=20
> option or it's a limitation ?
> regard
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
Hi Jessica,

Which tracepoints are you using?  If you're talking about net_dev_queue,=20
netif_receive_skb, netif_rx, then the information it shows is very=20
limited.  I have an experimental branch which adds data to those=20
tracepoints, mostly the network header if it's IP or IPv6 and transport=20
header if it's TCP.  But the network interface mode is not one of those=20
data, though if you know how to find it, it may (or may not) be fairly=20
easy to add.

Here's the git branch
http://git.dorsal.polymtl.ca/~gbastien?p=3Dlttng-modules.git;a=3Dsummary
branch net_data_experimental

Regards,

Genevi=E8ve

--------------020702080508060705000406
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 06/26/2013 12:58 AM, Jessica Foest
      wrote:<br>
    </div>
    <blockquote
cite="mid:CAPxN80A4-Fa3hhA8+zmmckhwRrp0qb2+xXcebw8tmB1QXGULzw@mail.gmail.com"
      type="cite">
      <div dir="ltr">
        <div>
          <div>
            <div>Hi<br>
              <br>
              when use lttng network tracepoint it didn't display
              network interface mode (like promiscuous mode or other ) .
              did i miss some tracepoint option or it's a limitation ?<br>
            </div>
          </div>
        </div>
        regard<br>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    Hi Jessica,<br>
    <br>
    Which tracepoints are you using?&nbsp; If you're talking about
    net_dev_queue, netif_receive_skb, netif_rx, then the information it
    shows is very limited.&nbsp; I have an experimental branch which adds
    data to those tracepoints, mostly the network header if it's IP or
    IPv6 and transport header if it's TCP.&nbsp; But the network interface
    mode is not one of those data, though if you know how to find it, it
    may (or may not) be fairly easy to add.<br>
    <br>
    Here's the git branch <br>
    <a class="moz-txt-link-freetext" href="http://git.dorsal.polymtl.ca/~gbastien?p=lttng-modules.git;a=summary">http://git.dorsal.polymtl.ca/~gbastien?p=lttng-modules.git;a=summary</a><br>
    branch net_data_experimental<br>
    <br>
    Regards,<br>
    <br>
    Genevi&egrave;ve
  </body>
</html>

--------------020702080508060705000406--


--===============0057655171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0057655171==--
