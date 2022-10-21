Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69869C433FE
	for <lttng-dev@archiver.kernel.org>; Fri, 21 Oct 2022 18:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1666377537;
	bh=kkUXoiDrgLInGdspE+z7BB7eaWWojN8vwxdvyn8IiTM=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RzOVj67EiL68d+jxHutu/2BaGx2+q7sIvTpsAasZEgNz4r4Q50KYH32ck5fr98pgf
	 mw2zmI1BfJPbxZ0mX8X1FGfonKSEr4f9SL0VL8Cnp/9pjD9zJaPfxxgfPgaMrHIe6/
	 z7POYmj2+9AtyLVQhDusI/HJKaANicS+/Z3IsBgIsT2cpTXHEz38IHBDUTVtxjqZon
	 MNl9GFQxFAA0MLH9+4EmfmlizdbqD7fcm/oX1hDo5+ImM6h2EP/fqpGlRvClOHQiSr
	 M7TKJ/HJi4l4SBA9IYde9R+dQbbovTLlFQQvkMQBezzAm5jJ2KMfDtK9Fc4Bm9YhWE
	 RdOj/zm3/kXCA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MvCsr3XMfzD5v;
	Fri, 21 Oct 2022 14:38:56 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2071.outbound.protection.outlook.com [40.107.116.71])
 by lists.lttng.org (Postfix) with ESMTPS id 4MvCsp57J6zB4S
 for <lttng-dev@lists.lttng.org>; Fri, 21 Oct 2022 14:38:49 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXkMgrm+2FghmIP9x/gx05QiTxyFwZhT70eAJ6QZjMcrEUR4LZ50m/+zxeGrCefjWy870HCjljE4ub6MX8LlZIFA3BjKG53rABSsrXZUj9vteOlKRJA44oFTwHJC2UFKxBiRPQKKVY8cNepl8/Dyvxbxs5E+sJmwJWVMyRpwWqTWplSxBki5CsdWBG8+k/ZIv57DbV9ysVCNikKNyDgEISSJdBcHp63e2PkiqfTl42tZow54Dd0X6LG1ndCoBW1hKc38LlGxJKUDdCMcVw9pey7zQ9CSH94xbkPWmWD1wBrmUw6bPVTAtfnP39AbSF7u8uXK8cnmSrjuPK+jbM98AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzVyy8iqmAiRvDlEQrzQ1ghji1TAWfa35RjOZSs8P7s=;
 b=Ba9D1ByenHAvuea4kD7h+gk9QqbCiws2wQjHfUuLm48cZx2Nz0CPm9cDZPTlUPI9RqXaKY3v/zKfJ1ygYqiPPTdeF9lDtg1BgJ/2JjO9BWD1JZmQGkfgypr9lG7/KFQNSUUfJBfskHNcCMeFMGMfMssMVgpiEmvxduBr6LVVkxM1L2yXWsjRi4SAHqONGAIXe76xK9cKsBUxg+xQrgFJXBGTEyEaAtWDye5GL3Wk6bb8gaEvbnIX5LinAIHcQ54A89ZPbzPcngalgiFu5AlaBsgV1eM0WVF0dvUpTglWgzgeKuMb57JcONsCGNlpXsWsMvmSM2CF9sR4m6h9bNvW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:4e::11)
 by YT2PR01MB8424.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 18:38:47 +0000
Received: from YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::421e:2bde:2609:a173]) by YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::421e:2bde:2609:a173%7]) with mapi id 15.20.5746.021; Fri, 21 Oct 2022
 18:38:47 +0000
Date: Fri, 21 Oct 2022 14:38:46 -0400
To: Mikael Beckius <mikael.beckius@windriver.com>
Cc: lttng-dev@lists.lttng.org
Message-ID: <Y1LnNp1U0CafT2eS@efficios.com>
References: <20221020171226.3450-1-mikael.beckius@windriver.com>
Content-Disposition: inline
In-Reply-To: <20221020171226.3450-1-mikael.beckius@windriver.com>
X-ClientProxiedBy: YQBPR0101CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::30) To YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:4e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB5984:EE_|YT2PR01MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf2128a-36d6-49f0-c384-08dab3937d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTVAFVkAtHricLgtaPqIj3jnM4MfAXmdr1Sif3yThAeuLyGNeBY1Jkwq9yguNUVqQDhsbfvQrqdPl8I6ZRCdngJnFZIDYbucuIYpKh662AJ7DLJftxvcDOUA/jN6ZawnG9IyLz9/CsU+1FBTgRXMY5sWKfFXw3IlgvGqKX3yDbXccVa3sy5zFavUTtQqsQIha/OzxTYUfXG3m905r6/W95xQk9Ccy5KQb+LuIBt0IEdsmj3eNA5COMwwhBxl3WIen0TpVDPZGwh+LNIiHmiW+E8t82rlFXmj4lerRbnwp+YTwel+G2prnzR4RGNxEfcQBJk5+DL7CZzYe0hrF1Dq02i2jxCSNfBU9JSjpBYbnWSkBF6DpR5gZ8RKT8IG5Y3Hg/iPEDSgcaT4UPfsqO/+t8n+mt0bnFRT9Venj0lwxzzTPBzbagyJjDvfy/U4BdHquHAeMHlTxX7N/EcAXI+YF9s3QNUMnwUxHHlNE4/9zEqBCbD3bHewleCv3cLk1sfHtyO0xf2U8QoGQhONN3G0CunavxohJhDcJ3NxAVoy2uhqXl0Zfifrxl1t2WHv+Wm0423aUytb+GHuB5N6ZA1qIx3JCfQ4TyhSUrJzBt1o2sZ1qRnrukA3LZPKNsgKLhgGbb58cDHi8U6lcTj0izKn6BGxbfsN0xEvj+wcAar2ZycUq1gQqeRbC1SPhHj0GIrLNeb4B+vv6PLhpPTaoVCJ/Jh0Yx2QrD39q30j7TPl5SE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(136003)(346002)(396003)(366004)(39830400003)(42606007)(376002)(34096005)(451199015)(316002)(2906002)(6916009)(8936002)(36756003)(38100700002)(478600001)(6486002)(6512007)(5660300002)(966005)(26005)(6506007)(66476007)(66946007)(66556008)(186003)(4326008)(41300700001)(2616005)(8676002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?x9QyM2GLRjTm7JgHKoGc3wdqEfl+xLcJrUgZtMPyjjgoGrokBZjjI1QiAq?=
 =?iso-8859-1?Q?ktaElxpE6nZ+wjwwlzKz3rzEZmAO6u24ACGKjfXOyQjTtNjnWMZrdusiMe?=
 =?iso-8859-1?Q?9KZOhVZi9oPghJB93QdhlxrgcQr93IiOyFpjx5z1nkN2EqAAa/ehH07Bch?=
 =?iso-8859-1?Q?KQTud4JOlGUGECHzlLn+j6Ggz5zhwbNYzZ/xSlAf9ZNgC0zf8rtpLlcazn?=
 =?iso-8859-1?Q?sSgN8fjM1RldGSKSHxMDBXu/Lip9nZqgPPb2+oGLr5/17zNj618DhkBkzl?=
 =?iso-8859-1?Q?ESVi8e8xzyAMyNcSAe/p6DEBH7NqoBeXUJSmGJv63XNV3023iAfxeDhHfQ?=
 =?iso-8859-1?Q?uy17kpT3OUbzankck9MguW3Ssj3CbjJcPwUjjsmLP3Pr1dYkk6ES8glyku?=
 =?iso-8859-1?Q?99HlAG7h42RCHpQtl5lWs7u5AEW1acvTqe7/hsZoQQS4g/5bX/3Upjyaim?=
 =?iso-8859-1?Q?4bxek68wZ8zgOFljKFom0OYKm9R9XSogI2VXWNFdRqzXiLy22vEIelfcbx?=
 =?iso-8859-1?Q?KCogMK7yWfUE225TwfyLrHIgJBY56/TXyt4GzO8+BXijm/Q4jVdyLhaGIX?=
 =?iso-8859-1?Q?R44aJuFIcUCjCIF2yWzHQWafbjdNYDVSmsSQQ7WEFyY98mD+/31Mx/oXsh?=
 =?iso-8859-1?Q?dFrUwcRI/9WB2NwA9JDGLVJ5lY5F5nOjUA6LVz/k8pEtsBRTfr/weGB7zX?=
 =?iso-8859-1?Q?BXVzm8wgovwQe8eqlzUIhX/ItzEM8752dfeVAVX60Uto0zDcI1yGmv0n6i?=
 =?iso-8859-1?Q?w/8ZxUAtXD9RZee3C72yyzgXoTGaFaoTY7BFlCZ29k703EhoWIzWdlJlTx?=
 =?iso-8859-1?Q?cVVS2wRspxMHInlJLp7oDIspT27qb3208K3HaBcnzPT1VOxVXeKsa6WKW6?=
 =?iso-8859-1?Q?2NsoiJMUANtK+ckBHXyTOcsTU3rjhjArZUzCq+t/qNdU7XB2ZS4aDl7OcP?=
 =?iso-8859-1?Q?z3/VeBWYOYtRTSVObo6shg8DyPkU0PHe3S1nSb49sRqslKenEypgZaXnrP?=
 =?iso-8859-1?Q?6QdTYoL2nugq/dfObqk6DgpfdjTRirKkYnXVQa5pgYgc1qxQm54z6UWfaa?=
 =?iso-8859-1?Q?lBH4ttxWjV6fTiJLI8B/fcNmPTEj6ggVffzFgkZuCjtGNYe4fEGrwB0ICf?=
 =?iso-8859-1?Q?JKfuHwS2SOW02zgVmesCMYLSUyuUBUUabWI814PGIIswL74jvHmDM8Crjy?=
 =?iso-8859-1?Q?tbaC2FWFtfvMz8GB/4JHt6N9k8TaD8JZ2bkn75/7qFsTsIWV0cB4JeZBuS?=
 =?iso-8859-1?Q?NNkrrW7E8uFnzzlJL28MTQrlHiMnBRDBKzL8FswBz8Pw5oQdPYJM8gHkw9?=
 =?iso-8859-1?Q?ljE/cPKYLSzalF0Tpf8G+vuib9+FC6XMOJioj3pCo1GtxyveB0ORUTqhq1?=
 =?iso-8859-1?Q?yWlNXBRtPpPTkKFIyFlNDdJnt35adOUv+aiwu186r4WI9E3bLCki+4J0i7?=
 =?iso-8859-1?Q?l2X7hB+qJKB8+kKKai9DwF17qr2LdgxqO08/j4I/A9iXoC9Su5+xafydp1?=
 =?iso-8859-1?Q?sJzs9ggOlX/jQqnxpScYWcDONYgKH+gopd1NnJS/37wA7F6RIe/ZUiokX+?=
 =?iso-8859-1?Q?jCbrLsot27vqhiIFlhUPcQtSLOKcI8mbihExg9r7jIdlckmA7B+YERJb1U?=
 =?iso-8859-1?Q?UMF/4ijmz7mU3zSshjnvY1KZbATN8J7+Zv?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf2128a-36d6-49f0-c384-08dab3937d60
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB5984.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 18:38:47.7028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMjF+wfzNuiJD+dMGfyYcISlbh2pKCoEoGW1mehjhrVyg5eyRZcFhq8AV4RYr2pe+wPTz1vPKg/Be3ipnq28AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8424
Subject: Re: [lttng-dev] [PATCH] Fix incorrect number of tests in
 test_callstack
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi Mikael,

I'm getting the correct number of tests here.
Can you provide the full output of the test?

Thanks,
J=E9r=E9mie

On Thu, Oct 20, 2022 at 07:12:26PM +0200, Mikael Beckius via lttng-dev wrot=
e:
> regression/kernel/test_callstack                         (Wstat: 256 Test=
s: 12 Failed: 1)
>   Failed test:  12
>   Non-zero exit status: 1
>   Parse errors: Bad plan.  You planned 11 tests but ran 12.
> =

> Signed-off-by: Mikael Beckius <mikael.beckius@windriver.com>
> ---
>  tests/regression/kernel/test_callstack | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/tests/regression/kernel/test_callstack b/tests/regression/ke=
rnel/test_callstack
> index a4477fd7c..b5d604535 100755
> --- a/tests/regression/kernel/test_callstack
> +++ b/tests/regression/kernel/test_callstack
> @@ -9,7 +9,7 @@ TEST_DESC=3D"Kernel tracer - Callstack context"
>  =

>  CURDIR=3D$(dirname "$0")/
>  TESTDIR=3D$CURDIR/../..
> -NUM_TESTS=3D11
> +NUM_TESTS=3D12
>  TEST_APP_USERSPACE=3D"$TESTDIR/utils/testapp/gen-syscall-events-callstac=
k/gen-syscall-events-callstack"
>  TEST_APP_KERNELSPACE=3D"$TESTDIR/utils/testapp/gen-syscall-events/gen-sy=
scall-events"
>  PARSE_CALLSTACK=3D"$TESTDIR/utils/parse-callstack.py"
> @@ -123,7 +123,7 @@ function test_kernel_callstack()
>  # Only run userspace callstack test on x86
>  uname -m | grep -E "x86" >/dev/null 2>&1
>  if test $? =3D=3D 0; then
> -	NUM_TESTS=3D$((NUM_TESTS+11))
> +	NUM_TESTS=3D$((NUM_TESTS+10))
>  	RUN_USERSPACE_TEST=3D1
>  else
>  	RUN_USERSPACE_TEST=3D0
> -- =

> 2.34.1
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
