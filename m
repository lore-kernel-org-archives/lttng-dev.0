From: Dominik Taborsky <bremby@seznam.cz>
Subject: how to generate CTF metadata
Date: Sun, 15 Mar 2015 22:25:43 +0100
Message-ID: <5505F8D7.7060509__11033.0167612576$1426454878$gmane$org@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mxf1.seznam.cz ([77.75.72.123])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <bremby@seznam.cz>) id 1YXG3o-000217-U0
 for lttng-dev@lists.lttng.org; Sun, 15 Mar 2015 17:27:03 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hello,

I am working on a project that involves generating CTF metadata, but I 
am unsure about how to proceed. I am not sure about how to get 
information about types, i.e. their size, signedness, alignment and 
possibly other. I know this information can be gathered from DWARF. Is 
that the primary way to do this? Is there any other, reasonable way? Can 
you point me at some code that does this? How does the LTTng linux 
kernel module work?

Thanks.

Dominik
