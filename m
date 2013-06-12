From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: Will LTTng overwrite existing trace files after
 reboot, or continue where the previous instance left off?
Date: Wed, 12 Jun 2013 15:18:56 -0400
Message-ID: <51B8C9A0.9__43984.1091669679$1371064775$gmane$org@gmail.com>
References: <OFBF5287EA.D7EE217E-ONC2257B88.004F3A88-C2257B88.004FF39E@il.ibm.com>
	<51B88B11.3020401@efficios.com>
	<OF8E263FF5.555C4B70-ONC2257B88.0069603B-C2257B88.006995A6@il.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1633704632=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UmqZT-00032O-TN
	for lttng-dev@lists.lttng.org; Wed, 12 Jun 2013 15:19:04 -0400
Received: by mail-ve0-f171.google.com with SMTP id b10so6985226vea.16
	for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2013 12:18:58 -0700 (PDT)
In-Reply-To: <OF8E263FF5.555C4B70-ONC2257B88.0069603B-C2257B88.006995A6@il.ibm.com>
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

This is a multi-part message in MIME format.
--===============1633704632==
Content-Type: multipart/alternative;
 boundary="------------080202090005030300030607"

This is a multi-part message in MIME format.
--------------080202090005030300030607
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 2013-06-12 15:14, Amit Margalit wrote:
> Indeed the path is _not_ different. There is no date-part in the path.
> I simply have ~/lttng-traces/ust/uid/<uid>/64-bit/ ...
That's really strange, you should have the session name between
"lttng-traces/" and "ust". 
That feature has been there since the beginning of the 2.x serie if I
remember well.

--------------080202090005030300030607
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 2013-06-12 15:14, Amit Margalit
      wrote:<br>
    </div>
    <blockquote
cite="mid:OF8E263FF5.555C4B70-ONC2257B88.0069603B-C2257B88.006995A6@il.ibm.com"
      type="cite"><font size="2" face="sans-serif">Indeed the path is <u>not</u>
        different.
        There is no date-part in the path. I simply have
        ~/lttng-traces/ust/uid/&lt;uid&gt;/64-bit/
        ...</font>
      <br>
    </blockquote>
    That's really strange, you should have the session name between
    "lttng-traces/" and "ust".&nbsp; <br>
    That feature has been there since the beginning of the 2.x serie if
    I remember well. <br>
  </body>
</html>

--------------080202090005030300030607--


--===============1633704632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1633704632==--
