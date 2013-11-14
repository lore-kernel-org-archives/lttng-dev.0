From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: might_sleep warnings in overwrite mode
Date: Thu, 14 Nov 2013 12:16:53 -0600
Message-ID: <52851395.3010306__12577.303479384$1384453091$gmane$org@mentor.com>
References: <52803E5D.3050109@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Nathan_Lynch@mentor.com>) id 1Vh1TU-0004cp-8A
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 13:17:09 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1Vh1TO-0003zd-1c from Nathan_Lynch@mentor.com
	for lttng-dev@lists.lttng.org; Thu, 14 Nov 2013 10:16:58 -0800
In-Reply-To: <52803E5D.3050109@mentor.com>
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

On 11/10/2013 08:18 PM, Nathan Lynch wrote:
> At this point I cannot trigger the issue without overwrite mode on
> 3.11.6, but on a 3.8-based vendor kernel I can recreate it regardless of
> the mode.

Some updates on this:
- It's not specific to overwrite mode; I was able to provoke it on
3.11.6 without --overwrite.  Overwrite mode does seem to recreate the
issue more readily.
- It seems to be GCC version-dependent.  4.8.1 and 4.8.2 produce code
which warns/bugs; 4.7.3 does not.
