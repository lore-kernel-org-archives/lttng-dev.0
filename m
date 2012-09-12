From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: list configured filters in LTTng Tools 2.1
Date: Wed, 12 Sep 2012 13:57:58 -0400
Message-ID: <5050CD26.6020707__46280.0964749933$1347472741$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr3.ericy.com ([198.24.6.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1TBrCr-00051J-2s
	for lttng-dev@lists.lttng.org; Wed, 12 Sep 2012 13:58:33 -0400
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
	by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id q8CHvh0p024135
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <lttng-dev@lists.lttng.org>; Wed, 12 Sep 2012 12:58:27 -0500
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

Hello

I configured a filter for UST events (lttng enable event -u ust* 
--filter 'signal==10101') and I want to retrieve that information 
afterwards. I used "lttng list mySession" and it only shows [with 
filters]. Is it possible to retrieve the actual filter expression? If 
not, it would be good to add this possibility.

Best Regards
Bernd


-- 
This Communication is Confidential. We only send and receive email on 
the basis of the terms set out at www.ericsson.com/email_disclaimer
