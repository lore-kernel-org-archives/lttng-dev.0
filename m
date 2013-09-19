From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [RFC PATCH lttng-tools 2/2] Implement dynamic
 instrumentation with dyninst
Date: Thu, 19 Sep 2013 16:31:28 -0500
Message-ID: <523B6D30.3020205__36597.6802110255$1379626356$gmane$org@mentor.com>
References: <CAJ7wx-EDBibZ-MO7pWfGGBdx+2yzN7pENpWpEoWAj7r5hDSGSA@mail.gmail.com>
	<1378292441-18272-1-git-send-email-soariez@gmail.com>
	<1378292441-18272-2-git-send-email-soariez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Nathan_Lynch@mentor.com>) id 1VMlp2-0006VF-Gk
	for lttng-dev@lists.lttng.org; Thu, 19 Sep 2013 17:31:41 -0400
In-Reply-To: <1378292441-18272-2-git-send-email-soariez@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello,

On 09/04/2013 06:00 AM, Zifei Tong wrote:
> This patch provides a *very* basic implementation of dynamic
> instrumentation support using dyninst library.

Looking through dyninst's source and web site, it appears to support
only x86 and PowerPC architectures; is this correct?
