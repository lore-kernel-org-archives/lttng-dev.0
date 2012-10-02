From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: lttng destroy fails
Date: Tue, 2 Oct 2012 14:47:23 -0400
Message-ID: <506B36BB.4040808__6762.3975257904$1349203713$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1TJ7VJ-0004PM-Dz
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 14:47:37 -0400
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q92IsgjS029218
	for <lttng-dev@lists.lttng.org>; Tue, 2 Oct 2012 13:54:44 -0500
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

I noticed a minor issue when executing the following command sequence:

 > lttng create auto
Session auto created.
Traces will be written in /home/bernd/lttng-traces/auto-20121002-144207
 > lttng destroy
Warning: Session name auto not found

The session is sill around after that. I think the problem is that in 
the file .lttngrc the wrong session name is stored. In the file .lttngrc 
the session name "auto" is stored but the actual name is 
"auto-20121002-144207".

BTW, I'm using lttng-tools 2.1 RC4.

BR,
Bernd

-- 
This Communication is Confidential. We only send and receive email on 
the basis of the terms set out at www.ericsson.com/email_disclaimer
