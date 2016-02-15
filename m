From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: [PATCH lttng-ust] Fix: Use Java 6 syntax in JUL
 examples
Date: Mon, 15 Feb 2016 14:43:32 -0500
Message-ID: <56C22A64.7010003__712.369362782006$1455565472$gmane$org@voxpopuli.im>
References: <1455564598-16049-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1aVP3d-0005f9-TD
 for lttng-dev@lists.lttng.org; Mon, 15 Feb 2016 14:43:44 -0500
In-Reply-To: <1455564598-16049-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Reviewed-by: Alexandre Montplaisir <alexmonthy@efficios.com>

On 2016-02-15 02:29 PM, Michael Jeanson wrote:
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
>   doc/examples/java-jul/ApplicationContextExample.java | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/doc/examples/java-jul/ApplicationContextExample.java b/doc/examples/java-jul/ApplicationContextExample.java
> index 3da3ac8..52cef3f 100644
> --- a/doc/examples/java-jul/ApplicationContextExample.java
> +++ b/doc/examples/java-jul/ApplicationContextExample.java
> @@ -67,12 +67,11 @@ public class ApplicationContextExample {
>   
>   		@Override
>   		public Object retrieveContextInfo(String key) {
> -			switch (key) {
> -			case CONTEXT_NAME_SHORT:
> +			if (CONTEXT_NAME_SHORT.equals(key)) {
>   				return (short) 42;
> -			case CONTEXT_NAME_STRING:
> +			} else if (CONTEXT_NAME_STRING.equals(key)) {
>   				return "context-value!";
> -			default:
> +			} else {
>   				return null;
>   			}
>   		}
