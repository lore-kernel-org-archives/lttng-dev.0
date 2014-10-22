From: "Boisvert, Sebastien" <boisvert@anl.gov>
Subject: Padding with Fs in babeltrace for a 32 bits field
	(ctf_integer_hex)
Date: Wed, 22 Oct 2014 20:34:33 +0000
Message-ID: <E949C1E351B4914B87A26A5F96E06A9286B328__40549.771677661$1414010147$gmane$org@PAYTON.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mailrelay.anl.gov ([130.202.101.22])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <boisvert@anl.gov>) id 1Xh2cC-0004oD-3D
 for lttng-dev@lists.lttng.org; Wed, 22 Oct 2014 16:34:43 -0400
Received: from mailgateway.anl.gov (mailgateway.anl.gov [130.202.101.28])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by mailrelay.anl.gov (Postfix) with ESMTP id 7FA267CC13E
 for <lttng-dev@lists.lttng.org>; Wed, 22 Oct 2014 15:34:34 -0500 (CDT)
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

I am using LTTng-UST (lttng 2.4.1-1.el6) and babeltrace (1.2.1-1.el6) on CentOS 6.5 (using EPEL).

I have 2 hexadecimal fields:

      ctf_integer_hex(int, script, actor->script->identifier)
      ctf_integer_hex(int, action, message->action)

One of them is printed with leading Fs (64 bits) while the other is fine (32 bits), but both should be 32 bits wide.

[14:52:27.416502837] (+0.000005124) silverclaw.novalocal thorium_actor:receive_exit: { cpu_id = 6 }, { name = 1000452, script = 0xFFFFFFFFEB3B39FD, action = 0x7724, count = 41 }

I expect "script = 0xEB3B39FD" and not script = 0xFFFFFFFFEB3B39FD since this is a int (sizeof(int) is 4).

Am I doing something wrong ?
