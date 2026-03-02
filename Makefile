
compile:
	npx swagger-cli bundle -t yaml -w 300 management-base/main.yml > output/managementBaseCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 management-bll/main.yml > output/managementBllCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 user-base/main.yml > output/userBaseCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 user-bll/main.yml > output/userBllCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 notify-base/main.yml > output/notifyBaseCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 sku-base/main.yml > output/skuBaseCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 sku-bll/main.yml > output/skuBllCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 order-base/main.yml > output/orderBaseCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 order-bll/main.yml > output/orderBllCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 agency-base/main.yml > output/agencyBaseCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 agency-bll/main.yml > output/agencyBllCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 logistics-base/main.yml > output/logisticsBaseCompiled.yml
	npx swagger-cli bundle -t yaml -w 300 logistics-bll/main.yml > output/logisticsBllCompiled.yml

lint:
	npx swagger-cli validate user-base/main.yml  
	npx openapi-generator validate -i output/userBaseCompiled.yml 
	npx swagger-cli bundle -t yaml -w 300 management-base/main.yml > output/managementBaseCompiled.yml

ts: 
	npx openapi-generator generate -i output/userBaseCompiled.yml -g -typescript-fetch -o output/typescript/userBase
	npx openapi-generator generate -i output/notifyBaseCompiled.yml -g typescript-fetch -o output/typescript/notifyBase
	npx openapi-generator generate -i output/cardBaseCompiled.yml -g typescript-fetch -o output/typescript/cardBase
	npx openapi-generator generate -i output/orderBaseCompiled.yml -g typescript-fetch -o output/typescript/orderBase
	npx openapi-generator generate -i output/agencyBaseCompiled.yml -g typescript-fetch -o output/typescript/agencyBase
	npx openapi-generator generate -i output/managementBaseCompiled.yml -g typescript-fetch -o output/typescript/managementBase