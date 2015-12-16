From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [PATCH lttng-tools] Tests: fix make targets using
 objcopy
Date: Wed, 16 Dec 2015 09:03:58 -0600
Message-ID: <56717D5E.1030004__33977.6672226892$1450278314$gmane$org@mentor.com>
References: <1449080769-18845-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1a9Dcd-0003fm-DH
 for lttng-dev@lists.lttng.org; Wed, 16 Dec 2015 10:04:09 -0500
In-Reply-To: <1449080769-18845-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

On 12/02/2015 12:26 PM, Michael Jeanson wrote:
> Add detection for objcopy using AC_CHECK_TOOL and use dedicated make
> targets for each file.

I have verified that this patch fixes cross compilation, please apply.
