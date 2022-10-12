Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFB7C4332F
	for <lttng-dev@archiver.kernel.org>; Wed, 12 Oct 2022 10:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1665570334;
	bh=ugwp3dAAX7GJMCx7PZhC414Lk1Lk6wHDt3ikVuU9nfU=;
	h=Date:To:References:Cc:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=EtHKm0A5RYND308uiwrZze00J1Pk4eWfy6K6dEu18dgeCLcGcrwHgNo0x3BhLQFZP
	 YmA95A41jCSuJFkckwrnBWih0hJPmu0FBj7b33vLoQ6ndCUsSeDM+hFHPMO8IEv9zO
	 2FgXLjIeIWSdS8PfK+X1VseAhAJ9Axf6LmaFPEkNhe58ir7gMVmnrwlUl+0zrbifz5
	 TJl06Gkxx9RXws1QDakugENUgGVP2CjqTRZnEGbPLEhxTZcZncH51qfvzt3bQrB3cf
	 2ZpOtQFsu1n+lY0I4A2Rh+BZuDW3bLzrbCNoFHVV9h/BrYAhLxpoTxmkUDNg3eOJO9
	 fA8/Loo8I5ahA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4MnTLj6L4yz6tS;
	Wed, 12 Oct 2022 06:25:33 -0400 (EDT)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on2041.outbound.protection.outlook.com [40.107.116.41])
 by lists.lttng.org (Postfix) with ESMTPS id 4MnTLh2662z72T
 for <lttng-dev@lists.lttng.org>; Wed, 12 Oct 2022 06:25:32 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLbSNzw8aM69IbEYeEy6S/zSGnzcsi4jqDBAzfy9l6u+SvZIx5BJP/qc7lj+2z5V8aJIjXyZsYRG+rXhZl4W69LqLPX6i9ngyZ2SxDyjQjL0jyi/sFKJauCL4zwnMUM/RJAaCusxddQ2wkxUIRWZGaGle0YFwGGJrhBeStCMlu+gmn5ewCSR7USl5M6h+9s2P6ZhO0byrStw8v5eFpCEOjfVTnt9KUJe3f47GlPFJHvT8GTxkgwgrBUtStW4z7XB5uTj/6XmgG5f1qfUymqL08CFH0FSlNMQ4YAnwkXn9IEQ9Rqce0fdQdixhM3AD4UjDdRlmZRp7qvjI6HNiP2P9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwrcR/R1ig+zQT8lilZD0DDW+0K+tLn12xc8j1LS3+M=;
 b=aMhG78EJF+e8hxoAO9Uw69xkCQrkUO8TQR4k5rW4GUTn+Xko2bDH+N13P0QG6RZzwTHPefr1qwF/neZ8XwlN6MC8hibChaRaN6mUCzWGYfCLuog01exW56cFnMqEnDxQRykxgf4wAH5RBjvY8UdWtAeGnW/UEgCnhDwSwGSP3G7zhrsRHcsd4XrriQxwEbZxpi2X0YHB5pqMk3CivyIB67GEXmiR4xlSBO6Pb4NwE438cRbaMc27CsyYJbRRcL1k6q+hwhzcOT541H+mkS/rRNwSLmaW33MVnj1ovIVO5SOjm3a1EDZ4nhP+il9W6soO/wIpBYOWo3DoH4OUzx1IIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YQXPR01MB6155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:28::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 10:25:30 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::47e0:e08d:935a:3bf7]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::47e0:e08d:935a:3bf7%3]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 10:25:30 +0000
Message-ID: <f69eeb15-2c5d-6346-6b97-b56ff3b7e5c3@efficios.com>
Date: Wed, 12 Oct 2022 11:25:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
To: lttng-dev@lists.lttng.org
References: <CACXehJBSQAmFSKRzSPp9Cg2ZNjmF1UaujnSPeDQvyJBTW0L4Qw@mail.gmail.com>
Content-Language: en-US
Cc: Maksim Khmelevskiy <mk.void.mail@gmail.com>
In-Reply-To: <CACXehJBSQAmFSKRzSPp9Cg2ZNjmF1UaujnSPeDQvyJBTW0L4Qw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0261.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::14) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YQXPR01MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f938319-1711-4263-6571-08daac3c1676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G20MQLmvFXtgcssxxPhaB9o4v22VEGjzQpoWyar6FdrAODbo2PYw5WioS9uFX82lG3yAw1zKGmjVwPOilxKbXqVD59SN2gYnTzaYsutdeXOmCFDLJWKfjbTGA+v7qo112He9MAbQYgjow+F2sCzG9nQGvzVYHcfMo6HxgWu8SC6DslaFBdpUbFqOCT6pGvHOdEQcLZJ0aWfm48gs9Z5Jqb/7qENU30tGkhkTzpGAqjTAXPWMig6Ze2Lbq3652cneS7UrXu0eNayYBLjvQS3LLYYZV1m/VdTIz/CrK52G64SCgXsqmvKtqIbMGm0nRi/7jafM4bTK3KpYxxIzkE6EJ6MdzkoX4k6iKuNmnqx9dsB/V/opxFiI1Jv6K0AYO6yI8TsGt1Z9/1fKT8o8ew7NVcMYdAgProC0Jtp0KzOCjfQTlVOBVqPd/aiP1wD5zdewjykGYiOy8hQ/u6NopVsz1u7+BHGwpzIPxOOGX2SBAMOZFh7WI7B2vbD1gckSs2o18NIG/hP3yMTSs5UnqAidEHoaOcDVGTre3EVWQ9ItVntttHPMQR9SEo6ww/T/Uk4L3WSzAX7mS8qLPmnMyWC039kOQNG4SicBNFt8v7isNmCl8HOkNo5MXfR5TyGhjTbqaPh7Mu3q8QtPIz4f+nazvA5zRbLW3b2qif3gIeH/S7DlYsuXwyaAzTk2WgjCBtmRqhLBFuMWAKX3JaPYHfaK4Xu7SIVBSNrQbz6GDtDQJNLaEEWz9Pd7ajtOSBZS8mPC+8W+Tcoq6a5RMGUD3rrtbowosgeRuf1OdjkVffdHw7TgDh3uMTSbeIBQP5vxzfKs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230022)(376002)(136003)(366004)(39830400003)(396003)(34096005)(346002)(42606007)(451199015)(2616005)(6916009)(36756003)(186003)(316002)(83380400001)(6666004)(86362001)(41300700001)(2906002)(31696002)(6486002)(5660300002)(966005)(478600001)(8936002)(38100700002)(6512007)(4326008)(8676002)(6506007)(66476007)(53546011)(31686004)(66556008)(66946007)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVR1ajlTUnQ1eHdxd2ltbTI1Q29JSTJHc294UDlJenh0QnMrdWZJYTB4cjFU?=
 =?utf-8?B?U0dGd2FlV25KMmwwZkpNZW1SNGtqSkxHSU1pZnFKQmRTYmlFanNlN0U3SDVE?=
 =?utf-8?B?d0FJTHdGVWRVaWlDQ0R1Mnh1QmRZdkErRFpseDZDTzN5aHRzdXdoOGJhOGFZ?=
 =?utf-8?B?YzFudnA2ck5iRDZtcEcyRUVxRktrUWJLMnZRc3RaakFMUU1EU290d3ZpckpR?=
 =?utf-8?B?VkVvZHh6TEdQQXVldGNVMTdRVENMTzhwUjJFYkVXdzgrUHBhYW84V0lzMGdE?=
 =?utf-8?B?VHNjamUwckVNTzlmM1dqQzgrWnE0dHFUV1o2YS9zT2p0dXoyTXNjdDY1R2tO?=
 =?utf-8?B?S21jT1Q0a2hrcXp1Ry9vSC9WRzNyYTAwQ2puM3ZDZ3hyTjIreXgvWVZDemU0?=
 =?utf-8?B?K3dpS21iTGRFYTNQbmd2d1AvbHY1ZlFUVDB2SUhwczV4TVZOMi9pcUtuMHRY?=
 =?utf-8?B?SVVhRVZ0RDBZK2xmeGJIRjVyMU11dUIwb2IyUFpWNE9GNEdWdUFzZ1NkZ3R6?=
 =?utf-8?B?M2gwZk11L2crV0NJU3Z3bitEeCtkK1BYT0hzMmRHRWh3cVZON2VqME94QkZw?=
 =?utf-8?B?NjhDaGtRRHBtRFhwZERUSFBpT1VCYWtGNzJGQ3pIQUVzSnhybDNML1VpTW9P?=
 =?utf-8?B?WGlOazJFa1Q2Z3VBbjd0SERrNkZpaDlUa3dFUTNGZ1ltSEVJYU1BQSt2Rmtp?=
 =?utf-8?B?YTdiR0pEaU1xdG96UituZDdtVnB0enFaNkVZWDgzOE51OFMvUVozSUJBR2lZ?=
 =?utf-8?B?cGpoM2VaZEdLNXN3UnZ0czh4M2ttWE1jTUNtZjFjQ1kvaExWZkpaUE1FTERW?=
 =?utf-8?B?Ukl2R1k5dnFoc2YrS0J0R0txUm1URmExZDM1blJUWU5OcDJYcXArdkNwalVy?=
 =?utf-8?B?eStNQ1NUdVhsZWF4aE1tU3h2eDcyMzJ5YmN2RXcrQmNta2RqUkV0RXJFZ1BL?=
 =?utf-8?B?T0RucDJJMHZKZzR1YmZCRFFrRjVQTGNFeFJkZy9MaFUrNmJjc0EzRXNhZ0hY?=
 =?utf-8?B?aW1wcWJpRnJIUG5UOG9CV0s4emo3dVlPSnBpVnFiVkhEVmdYeTZLdm8vSWU1?=
 =?utf-8?B?aFpxTUQ0K0UwTU1XM1FyRElQM2pvU2o5ZS94Z0drLzFPcHB1VEIxOU53Tkha?=
 =?utf-8?B?OTNQZkRMZWhMeStvM2ZPN2N6WE5LeEMxUXgrWWxLMldmd1psZGYzTzdyYTFv?=
 =?utf-8?B?TnJkNHNMN1A2RHo1N2Fjbm0xZjAyWGsveUZjekVNNU5BczRsT2pjVk9BL1Jr?=
 =?utf-8?B?U3hacXVHelBrRjF4WlBXZjNXZGpFaXhmM1E4YlQ2K2hOZjBPM3pnWTZtWU90?=
 =?utf-8?B?cHFGVUNteTVKR1BRR3ZjL0dXSUlHYTk5VEhDdS9BYmROZTBhUE5jZWoyZWkv?=
 =?utf-8?B?dTJMSWl2ckZUcElGTnBSaGpaZ2d5NlpZS0Y3OTNkYnVWcTNOWWpqaElTOHNv?=
 =?utf-8?B?MjhTOXE5dEx2Y3Y4S1ZIbDU4SElyNC81eGY0b3Exci9JVUdHZGJwUVhtbWVs?=
 =?utf-8?B?Y0dpYlpLOXVUYlEvM0ttaVJoMittRHpkRERsYzRiVkVXV1U3d0IwQWhIZ2Ey?=
 =?utf-8?B?VStMVmUxQzM2SkNmWTJkWGY4U0RQbm5rb2FENlkxZ01uamJEWlpJbTV2cXFU?=
 =?utf-8?B?cHhjWjFIY0NhS2xGQndHbTFNQU5jSWx0NHI1NlFySXJaUksxYUZ3cWFidDRm?=
 =?utf-8?B?aEpPTXhJVEc5VGNwZjNZMERuS296TERkaGVtbWl1dFBOa0Vpa0QvSTl4OURJ?=
 =?utf-8?B?S1I1ajhaNUFHektub3pkUmVJeXJ4bVgzT2dhekt3a1ZSWHZkUnJzT256NUoy?=
 =?utf-8?B?RlVrMGNEWm5VR1JLK3p1M0MvMlM0RVVac3hDODVLQVBWVzlldWFUN0llSis0?=
 =?utf-8?B?WlVML1UvSWJ3L1Njdno4M1FPMTVQRWhLWmFhQlkvdE1Xa0VFbVcyNkh1WFJn?=
 =?utf-8?B?aUlDaE5qR2t6MysxOHpPUXJ1ZzBaNHVrUFFwV1lRNUxqL2VzRHQzbnNmUzht?=
 =?utf-8?B?cmJaVUx0eS9vcnMxbkV5dGNrYVdmVk5zM2JaajFUSm1TRm5XVXN2UXRhbGNu?=
 =?utf-8?B?dnJWZE9CMVZwbWtaUzZrWmYvUlVROWtFL2FOY3VHZXpkNjRCUG9uaVl1QWlJ?=
 =?utf-8?B?MGluY21sSDYyeUx5Y2MzVTg3MlJROTI3THJVSGpnQ0RFcDJGdDdWTlB3NlFZ?=
 =?utf-8?Q?2Rtxz4GUTUeE/ZowXfKnzgD8R7rV78Euvk2irGVpgfw8?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f938319-1711-4263-6571-08daac3c1676
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 10:25:30.3250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tK8ZMZLY1tAyiCmZElqAEQaqhaOBrAPcppEs+SnFVWM6aMLgmkrvjrDCvJEd7tMopH4SM7aNiDAKzhH+3KKiig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6155
Subject: Re: [lttng-dev] LTTng and containers.
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
From: Michael Jeanson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Michael Jeanson <mjeanson@efficios.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

On 2022-10-10 17:12, Maksim Khmelevskiy via lttng-dev wrote:
> Hi,
> 
> I would like to ask regarding the hot topic - container tracing. I've seen a 
> youtube video <https://www.youtube.com/watch?v=hra-eu6EOpY>, have read a 
> message <https://lists.lttng.org/pipermail/lttng-dev/2021-May/029952.html> 
> from LTTng mailing list and tried to google more about this topic but didn't 
> find much of info. Could you please direct me where should I continue digging?
> My problem:
> I would like to have multiple containers where traces are generated by apps 
> with compiled-in tracepoints. Traces could be stored in these containers as well.
> Besides these containers I would have a trace processor container, a master 
> container which could address a container(or a trace session) and fetch traces 
> from it and read with babeltrace or similar tool.
> So far, intuitively, remote tracing comes to my mind but before continuing 
> with the task I would be happy to hear an advice from LTTng devs.
> 
> Thank you!

Hi,

You can either use lttng-relayd to send the traces over the network to your 
trace processor container, or just trace to disk on shared diectories. You 
should have a look at trace rotation, https://doc.lttng.org is probably the 
best place to start.

Michael

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
