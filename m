From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: CTF model.emf.uri precision
Date: Mon, 24 Sep 2012 16:52:28 -0400
Message-ID: <5060C80C.4030600__7241.00534939698$1348520006$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr3.ericy.com ([198.24.6.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1TGFeD-0005AX-1t
	for lttng-dev@lists.lttng.org; Mon, 24 Sep 2012 16:52:57 -0400
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
	by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id q8OKqoYK013736
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <lttng-dev@lists.lttng.org>; Mon, 24 Sep 2012 15:52:50 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi tracing paladins,
I was going over the most recent CTF specs. I am curious, at the line:
1176   "model.emf.uri = "string";" this looks like a reference to
something from eclipse modeling framework.
http://download.eclipse.org/modeling/emf/emf/javadoc/2.7.0/org/eclipse/emf/common/util/URI.html

Is this part of the CTF specification? Shouldn't this be called
model.uri or model_uri to respect the naming convention?

I hope someone could clarify this.

Matthew
