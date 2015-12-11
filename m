From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [PATCH] use AC_CHECK_TOOL for objcopy and strip
Date: Fri, 11 Dec 2015 10:45:41 -0600
Message-ID: <566AFDB5.8000103__36236.5458663136$1449852399$gmane$org@mentor.com>
References: <1449852204-11379-1-git-send-email-nathan_lynch@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1a7QpI-0001xD-J3
 for lttng-dev@lists.lttng.org; Fri, 11 Dec 2015 11:45:49 -0500
Received: from svr-orw-fem-05.mgc.mentorg.com ([147.34.97.43])
 by relay1.mentorg.com with esmtp
 id 1a7QpD-0004MA-7Y from Nathan_Lynch@mentor.com
 for lttng-dev@lists.lttng.org; Fri, 11 Dec 2015 08:45:43 -0800
In-Reply-To: <1449852204-11379-1-git-send-email-nathan_lynch@mentor.com>
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

On 12/11/2015 10:43 AM, Nathan Lynch wrote:
> The build steps for some tests refer directly to objcopy and strip,
> which when cross-compiling can result in:
> 
>  objcopy --only-keep-debug prog prog.debug
>  objcopy: Unable to recognise the format of the input file `prog'
> 
> Use AC_CHECK_TOOL to use appropriate programs for the target.

(This patch is for lttng-tools.)
