From: David Bryant <david.bryant@quantum.com>
Subject: Test if tracepoint is enabled
Date: Tue, 27 Nov 2012 14:39:42 +1030
Message-ID: <50B43D06.7020709__42708.1886599355$1353989431$gmane$org@quantum.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0038628318=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0a-000ceb01.pphosted.com ([67.231.144.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=7678429006=david.bryant@quantum.com>)
	id 1TdCUY-000317-83
	for lttng-dev@lists.lttng.org; Mon, 26 Nov 2012 23:09:50 -0500
Received: from pps.filterd (m0030277 [127.0.0.1])
	by mx0a-000ceb01.pphosted.com (8.14.5/8.14.5) with SMTP id
	qAR47Pk9018205
	for <lttng-dev@lists.lttng.org>; Mon, 26 Nov 2012 20:09:49 -0800
Received: from ppoxedge2.quantum.com ([146.174.252.28])
	by mx0a-000ceb01.pphosted.com with ESMTP id 18v7w89ye3-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <lttng-dev@lists.lttng.org>; Mon, 26 Nov 2012 20:09:49 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0038628318==
Content-Type: multipart/alternative;
	boundary="------------010204050601010106000007"

--------------010204050601010106000007
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

Is it feasible to have an officially supported way of determining if a 
tracepoint is currently enabled?

In my code I would like to test if the tracepoint is enabled, and if it 
isn't, avoid doing expensive setup work.

I've been doing the following:

   if 
(__builtin_expect(!!(__tracepoint_sample_component___message.state), 0)) {
       /* setup work */
       tracepoint(sample_component, message);
       /* cleanup work */
   }

But it's weak for two reasons:

  * The 'state' attribute goes true when the tracepoint is enabled, but
    stays true after the tracepoint is disabled. It only goes false when
    the session is destroyed.
  * It uses a private / unofficial API

What I'd like is an official API that correctly evaluates whether a 
tracepoint is enabled or not?

Is this possible?

Thanks,
Dave

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.

--------------010204050601010106000007
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Hi all,<br>
    <br>
    Is it feasible to have an officially supported way of determining if
    a tracepoint is currently enabled?<br>
    <br>
    In my code I would like to test if the tracepoint is enabled, and if
    it isn't, avoid doing expensive setup work.<br>
    <br>
    I've been doing the following:<br>
    <br>
    &nbsp; if
    (__builtin_expect(!!(__tracepoint_sample_component___message.state),
    0)) {<br>
    &nbsp; &nbsp; &nbsp; /* setup work */<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tracepoint(sample_component, message);<br>
    &nbsp;&nbsp; &nbsp;&nbsp; /* cleanup work */<br>
    &nbsp; }<br>
    <br>
    But it's weak for two reasons:<br>
    <ul>
      <li>The 'state' attribute goes true when the tracepoint is
        enabled, but stays true after the tracepoint is disabled. It
        only goes false when the session is destroyed.<br>
      </li>
      <li>It uses a private / unofficial API<br>
      </li>
    </ul>
    <p>What I'd like is an official API that correctly evaluates whether
      a tracepoint is enabled or not?<br>
    </p>
    <p>Is this possible?<br>
    </p>
    <p>Thanks,<br>
      Dave<br>
    </p>
  
<HR>The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.<BR>
</body>
</html>

--------------010204050601010106000007--


--===============0038628318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0038628318==--
