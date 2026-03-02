
# linkpay-springdoc


## getting start

1. pom加入這段
```
<plugin>
				<groupId>org.openapitools</groupId>
				<artifactId>openapi-generator-maven-plugin</artifactId>
				<version>7.1.0</version>
				<executions>
					<execution>
						<goals>
							<goal>generate</goal>
						</goals>
						<configuration>
							<inputSpec>
								${project.basedir}/src/main/resources/user-base.yml
							</inputSpec>
							<generatorName>spring</generatorName>
							<apiPackage>com.linkpay.userBll.api</apiPackage>
							<modelPackage>com.linkpay.userBll.model</modelPackage>
							<configOptions>
								<library>spring-http-interface</library>
								<useSpringBoot3>true</useSpringBoot3>
							</configOptions>
						</configuration>
					</execution>
				</executions>
			</plugin>
```

如果是server端，設定要改為
```

								<delegatePattern>true</delegatePattern>
								<skipDefaultInterface>false</skipDefaultInterface>
								<generateSupportingFiles>true</generateSupportingFiles>
								<supportingFilesToGenerate>ApiUtil.java</supportingFilesToGenerate>
								<useSpringBoot3>true</useSpringBoot3>
```

2. 生成程式碼
```
npm install -g @apidevtools/swagger-cli@4.0.4
npm install -g @openapitools/openapi-generator-cli@
npx swagger-cli bundle -t yaml -w 300 user-base/main.yml > output/userBaseCompiled.yml

openapi-generator generate -i output/userBaseCompiled.yml -g java -o target -c ./java_lang.yml
openapi-generator generate -i src/main/resources/linkpay-springdoc/output/userBaseCompiled.yml -g java -o target -c src/main/resources/linkpay-springdoc/java_lang.yml

mvn clean generate-sources
```


3. 將生成程式碼設為root

## server side

將degelate實作
https://blog.palo-it.com/en/spring-boot-client-and-server-code-generation-using-openapi-3-specs
```
@Component
public class PetApiControllerImpl implements PetApiDelegate {

    @Override
    public ResponseEntity<Pet> getPetById(Long petId) {
        if(petId == 1l) {
            var pet = new Pet();
            pet.setId(1l);
            pet.setName("Bear");
            pet.setStatus(StatusEnum.AVAILABLE);
            return ResponseEntity.ok(pet);
        }
        return new ResponseEntity(HttpStatus.NOT_FOUND);
    }

    @Override
    public ResponseEntity<Pet> addPet(Pet pet) {
        // TODO: Add implementation...
        return new ResponseEntity(HttpStatus.NOT_IMPLEMENTED);
    }

    // TODO: Override methods from delegate and implement
}
```


## client side

加入這個config

```
@Configuration
public class WebConfig {

    @LoadBalanced
    @Bean
    public WebClient.Builder webClientBuilder() {
        return WebClient.builder();
    }

    @SneakyThrows
    @Bean
    DefaultApi defaultApi(WebClient.Builder webClientBuilder) {
        HttpServiceProxyFactory httpServiceProxyFactory =
                HttpServiceProxyFactory.builder(WebClientAdapter.forClient(webClientBuilder.baseUrl("http://linkpay-order-base").build())).build();
        return httpServiceProxyFactory.createClient(DefaultApi.class);
    }

}
```

## ts生成   
```shell
npx openapi-generator generate -i output/agencyBaseCompiled.yml -g typescript-fetch -o output/typescript
```

## 參考
https://github.com/phrase/openapi/blob/master/schemas/member.yaml

https://github.com/OpenAPITools/openapi-generator/issues/4680

https://github.com/stripe/openapi/tree/master


用 <schemaMappings>HttpServletRequest=jakarta.servlet.http.HttpServletRequest</schemaMappings>
https://github.com/OpenAPITools/openapi-generator/issues/11506

## 其他問題
3.1.0的maven plugin有問題，會生出JsonNullable<Object>

