From: Sebastien Boisvert <sboisvert@gydle.com>
Subject: Re: [lttng-ust][PATCH] Add config time check for new
 gettid API
Date: Fri, 26 Jul 2019 14:01:49 -0400
Message-ID: <8c0971cc-7e14-805f-dbfa-f3d698b92f77__6562.59212862409$1564164141$gmane$org@gydle.com>
References: <20190726170731.16080-1-raj.khem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.gydle.com (mail.gydle.com [64.18.173.180])
 by lists.lttng.org (Postfix) with ESMTPS id 45wH3H0Jl5z1Jds
 for <lttng-dev@lists.lttng.org>; Fri, 26 Jul 2019 14:02:02 -0400 (EDT)
In-Reply-To: <20190726170731.16080-1-raj.khem@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Khem Raj <raj.khem@gmail.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org



On 2019-07-26 1:07 p.m., Khem Raj wrote:
> glibc 2.30 introdoced this function see [1]

introduced

> so its best to detect it

it's

> and provide fallbacks only if its not present

fallback

it's

> 
> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=6399
> 

That's interesting for the thread identifier context field.

Thanks

> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  configure.ac            | 1 +
>  include/lttng/ust-tid.h | 7 +++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 7fa059a..b1099c1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -137,6 +137,7 @@ AC_CHECK_FUNCS([ \
>  	clock_gettime \
>  	ftruncate \
>  	getpagesize \
> +	gettid \
>  	gettimeofday \
>  	localeconv \
>  	memchr \
> diff --git a/include/lttng/ust-tid.h b/include/lttng/ust-tid.h
> index e669d7e..7995c78 100644
> --- a/include/lttng/ust-tid.h
> +++ b/include/lttng/ust-tid.h
> @@ -26,7 +26,10 @@
>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
>   * SOFTWARE.
>   */
> -
> +#include <config.h>
> +#if HAVE_GETTID
> +#include <unistd.h>
> +#else
>  #ifdef __linux__
>  #include <syscall.h>
>  #endif
> @@ -49,5 +52,5 @@ static inline pid_t gettid(void)
>  	return getpid();
>  }
>  #endif
> -
> +#endif /* HAVE_GETTID */
>  #endif /* _LTTNG_UST_TID_H */
> 
